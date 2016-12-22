# coding: utf-8
require 'rails_helper'

RSpec.describe 'Auth', :type => :request do

  describe "Get token", :autodoc do

    let(:description) do
      "Returns access_token if authenticated.<br/>" \
      "Authenticate with username, password registered via /api/v1/users<br/>" \
      "If other APIs are requested with valid token, the expiration time of the token is extended<br/>"
    end


    let(:env) do
      {
        'CONTENT_TYPE' => 'application/json',
        'HOST' => 'triglav.analytics.mbga.jp',
        'HTTP_ACCEPT' => 'application/json',
      }
    end

    let(:params) do
      {
        username: 'test_user',
        password: 'Test_passw0rd',
      }
    end

    before do
      FactoryGirl.create(
        :user,
        :read_only,
        name: 'test_user',
        password: 'Test_passw0rd'
      )
    end

    it "POST /api/v1/auth/token" do
     
      post "/api/v1/auth/token", params: params.to_json, env: env

      expect(response.status).to eq 200
      
    end
    
  end


  describe "Revoke token", :autodoc do
    let(:description) do
      "Revoke access_token specified in Authorization header"
    end

    let(:params) do
      {}
    end

    let(:env) do
      {
        'CONTENT_TYPE' => 'application/json',
        'HOST' => 'medjed.analytics.mbga.jp',
        'HTTP_ACCEPT' => 'application/json',
        'HTTP_AUTHORIZATION' => access_token,
      }
    end
    
    let(:access_token) do
      ApiKey.create(user_id: user.id).access_token
    end
    
    let(:user) do
      FactoryGirl.create(:user, :read_only)
    end

    it "DELETE /api/v1/auth/token" do
      
      delete "/api/v1/auth/token", params: params, env: env

      expect(response.status).to eq 204
      
    end
    
  end

  describe "Current user", :autodoc do
    let(:description) do
      "Returns user associted with the token specified in Authorization header<br/>" \
      "The expiration time is extended if the token is valid<br/>"
    end

    let(:params) do
      {}
    end

    let(:env) do
      {
        'CONTENT_TYPE' => 'application/json',
        'HOST' => 'medjed.analytics.mbga.jp',
        'HTTP_ACCEPT' => 'application/json',
        'HTTP_AUTHORIZATION' => access_token,
      }
    end
    
    let(:access_token) do
      ApiKey.create(user_id: user.id).access_token
    end
    
    let(:user) do
      FactoryGirl.create(:user, :editor, name: 'editorial_user')
    end

    it "GET /api/v1/auth/me" do
      
      get "/api/v1/auth/me", params: params, env: env

      expect(response.status).to eq 200
      
    end
    
  end

end
