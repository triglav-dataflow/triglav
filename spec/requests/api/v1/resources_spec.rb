# coding: utf-8
require 'rails_helper'

RSpec.describe 'Resource resources', :type => :request do

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

  let(:resources) do
    [
      FactoryGirl.create(:resource, uri: 'hdfs://localhost/aaa.csv.gz', unit: 'singular',  span_in_days: 32, consumable: true, notifiable: false),
      FactoryGirl.create(:resource, uri: 'hdfs://localhost/aaa.csv.gz', unit: 'daily',  span_in_days: 32, consumable: true, notifiable: false),
      FactoryGirl.create(:resource, uri: 'hdfs://localhost/aaa.csv.gz', unit: 'hourly', span_in_days: 16, consumable: true, notifiable: false),
      FactoryGirl.create(:resource, uri: 'hdfs://localhost/aaa.csv.gz', unit: 'hourly', span_in_days: 48, consumable: true, notifiable: false),
      FactoryGirl.create(:resource, uri: 'hdfs://localhost/bbb.csv.gz', unit: 'daily',  span_in_days: 32, consumable: true, notifiable: false),
      FactoryGirl.create(:resource, uri: 'hdfs://localhost/ccc.csv.gz', unit: 'daily',  span_in_days: 32, consumable: true, notifiable: false),
      FactoryGirl.create(:resource, uri: 'hdfs://localhost/ccc.csv.gz', unit: 'daily',  span_in_days: 32, consumable: true, notifiable: true),
    ]
  end

  let(:resource) do
    FactoryGirl.create(:resource, uri: 'hdfs://localhost/aaa.csv.gz')
  end

  describe "Get aggregated_resources", :autodoc do

    let(:description) do
      "Get aggregated resources required to be monitored (i.e., consumable = true and notifiable = false).<br/>" \
      "<br/>" \
      "`resource_prefix` query parameter is required. " \
      "Each returned resource has `uri`, `unit`, `timezone`, `span_in_days` parameters. " \
      "`unit` is `singular` or `daily` or `hourly`, or their combinations such as `daily,hourly` or `daily,hourly,singular`.<br/>" \
      "<br/>" \
      "FYI: Aggregation is operated as following SQL: " \
      "`SELECT uri, GROUP_CONCAT(DISTINCT(unit) order by unit) AS unit, timezone, MAX(span_in_days) AS span_in_days GROUP BY uri`<br/>" \
    end

    before do
      resources
    end

    let(:params) do
      { uri_prefix: 'hdfs://localhost' }
    end

    it "GET /api/v1/aggregated_resources" do

      get "/api/v1/aggregated_resources", params: params, env: env
      json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(json.size).to eq 2
      expect(json[0]['unit']).to eq 'daily,hourly,singular'

    end
  end

  describe "Get resources", :autodoc do

    let(:description) do
      "Get resource index<br/>"
    end

    before do
      resources
    end

    let(:params) do
      { uri_prefix: 'hdfs://localhost' }
    end

    it "GET /api/v1/resources" do
      
      get "/api/v1/resources", params: params, env: env
      json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(json.size).to eq 7

    end
  end

  describe "Get a resource" do

    let(:description) do
      'Get a resource'
    end

    it "GET /api/v1/resources/:resource_id_or_uri", :autodoc do

      get "/api/v1/resources/#{resource.id}", params: params, env: env

      expect(response.status).to eq 200
      
    end

    it "GET /api/v1/resources/:resource_uri" do

      get "/api/v1/resources/#{CGI.escape(resource.uri)}", params: params, env: env

      expect(response.status).to eq 200
      
    end
  end

  describe "Create a resource" do

    let(:description) do
      'Create a resource'
    end

    let(:resource) do
      FactoryGirl.build(:resource)
    end

    let(:params) do
      resource.attributes.slice(*ResourceSerializer.request_permit_params.map(&:to_s))
    end

    it "POST /api/v1/resources", :autodoc do
      post "/api/v1/resources", params: params.to_json, env: env

      expect(response.status).to eq 200
      expect(Resource.all.size).to eq(1)
    end
  end

  describe "Update a resource" do

    let(:description) do
      'Update a resource'
    end

    let(:resource) do
      FactoryGirl.create(:resource)
    end

    let(:params) do
      resource.attributes.slice(*ResourceSerializer.request_permit_params.map(&:to_s))
    end

    it "PUT/PATCH /api/v1/resources/:resource_id_or_uri", :autodoc do
      put "/api/v1/resources/#{resource.id}", params: params.to_json, env: env

      expect(response.status).to eq 200
      expect(Resource.all.size).to eq(1)
    end

    it "PUT/PATCH /api/v1/resources/:resource_uri" do
      put "/api/v1/resources/#{CGI.escape(resource.uri)}", params: params.to_json, env: env

      expect(response.status).to eq 200
      expect(Resource.all.size).to eq(1)
    end
  end

  describe "Delete a resource" do

    let(:description) do
      'Delete a resource'
    end

    let(:resource) do
      FactoryGirl.create(:resource)
    end

    it "DELETE /api/v1/resources/:resource_id_or_uri", :autodoc do
      delete "/api/v1/resources/#{resource.id}", params: params, env: env

      expect(response.status).to eq 204
    end

    it "DELETE /api/v1/resources/:resource_uri" do
      delete "/api/v1/resources/#{CGI.escape(resource.uri)}", params: params, env: env

      expect(response.status).to eq 204
    end
  end
end
