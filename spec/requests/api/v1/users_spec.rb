# coding: utf-8
require 'rails_helper'

RSpec.describe 'User resources', :type => :request do

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


  describe "Get user index", :autodoc do

    let(:description) do
      "Returns user index<br/>" \
      "Group is not included<br/>"
    end

    before do
      FactoryGirl.create(:user, :project_admin, name: 'project_admin')
      FactoryGirl.create(:user, :editor, name: 'editable_user')
      FactoryGirl.create(:user, :read_only, name: 'read_only_user_1')
      FactoryGirl.create(:user, :read_only, name: 'read_only_user_2')
      FactoryGirl.create(:user, :read_only, name: 'read_only_user_3')
    end

    it "GET /api/v1/users" do
      
      get "/api/v1/users", params: params, env: env

      expect(response.status).to eq 200
      
    end
  end

  
  describe "Get a user", :autodoc do

    let(:description) do
      "Get a user"
    end

    it "GET /api/v1/users/:user_id" do

      get "/api/v1/users/#{user.id}", params: params, env: env

      expect(response.status).to eq 200
      
    end
  end

  describe "Create a user", :autodoc do

    let(:description) do
      "Create a user<br/>" \
      "`authenticator` parameter accepts only `local`<br/>" \
      "`ldap` users are automatically created on authentication<br/>" \
      "Specify an Array for `groups`"
    end

    let(:params) do
      FactoryGirl.attributes_for(:user, :read_only, name: 'new user').merge(password: 'Passw0rd')
    end

    it "POST /api/v1/users" do

      post "/api/v1/users", params: params.to_json, env: env

      expect(response.status).to eq 201

    end
  end

  describe '#check_authenticator!' do

    let(:params) do
      FactoryGirl.attributes_for(
        :user, :read_only, name: 'new user'
      ).merge(
        password: 'Passw0rd',
        authenticator: 'something_wrong',
      )
    end

    it "POST /api/v1/users" do
      post "/api/v1/users", params: params.to_json, env: env
      expect(response.status).to eq 400
    end

  end

  
  describe "Update user", :autodoc do

    let(:description) do
      "Update a user<br/>" \
      "`authenticator` parameter accepts only `local`<br/>" \
      "`name` cannot be changed (ignored even if specified)<br/>"
    end

    let(:target_user) do
      FactoryGirl.create(:user, :project_admin, name: 'original name')
    end

    let(:params) do
      attrs = FactoryGirl.attributes_for(:user, :read_only, name: 'new user')
      attrs[:name] = 'try to update name'
      attrs[:description] = 'try to update description'
      attrs[:groups] = ['editor', 'group1', 'group2']
      attrs
    end

    it "PUT/PATCH /api/v1/users/:user_id" do

      put "/api/v1/users/#{target_user.id}", params: params.to_json, env: env

      expect(response.status).to eq 200
      
    end
  end

  
  describe "Delete a user", :autodoc do

    let(:description) do
      "Delete a user"
    end

    let(:target_user) do
      FactoryGirl.create(:user, :project_admin, name: 'delete target')
    end

    it "DELETE /api/v1/users/:user_id" do

      delete "/api/v1/users/#{target_user.id}", params: params, env: env

      expect(response.status).to eq 204
      
    end
  end
  
end
