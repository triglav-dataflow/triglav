# coding: utf-8
require 'rails_helper'

RSpec.describe 'AndMessage resources', :type => :request do

  let(:params) do
    {}
  end

  let(:env) do
    {
      'CONTENT_TYPE' => 'application/json',
      'HOST' => 'triglav.analytics.mbga.jp',
      'HTTP_ACCEPT' => 'application/json',
      'HTTP_AUTHORIZATION' => access_token,
    }
  end

  let(:access_token) do
    ApiKey.create(user_id: user.id).access_token
  end

  let(:user) do
    FactoryGirl.create(:user, :triglav_admin)
  end

  let(:message) do
    FactoryGirl.create(:and_message)
  end

  describe "Fetch AND messages", :autodoc do

    let(:description) do
      "Fetch AND messages whose message id is greater than or equal to offset<br/>" \
      "<br/>" \
      "`offset` is required.<br/>" \
      "`job_id` is required.<br/>" \
      "`limit` is optional, and default is 100.<br/>" \
      "Returned `time` is in unix timestamp of returned `timestamp`.<br/>"
    end

    let(:params) do
      {
        offset: message.id,
        job_id: message.job_id,
        limit: 100,
      }
    end

    it "GET /api/v1/and_messages" do

      get "/api/v1/and_messages", params: params, env: env

      expect(response.status).to eq 200

    end
  end

  describe "Get last AND message id", :autodoc do

    let(:description) do
      "Get last AND message id which would be used as a first offset to fetch messages<br/>"
    end

    it "GET /api/v1/and_messages/last_id" do
      FactoryGirl.create(:message)

      get "/api/v1/and_messages/last_id", params: nil, env: env

      expect(response.status).to eq 200

    end
  end

end
