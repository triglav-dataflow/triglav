# coding: utf-8
require 'rails_helper'

RSpec.describe 'Job resources', :type => :request do

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

  let(:job) do
    FactoryGirl.create(:job_with_resources)
  end

  describe "Create or update a job" do

    let(:description) do
      "Create or update a job along with creating or updating resources.<br/>" \
      "<br/>" \
      "Create a job if its id is not given, and update a job if its id is given.<br/>" \
      "Create resources if ids are not given for input and output resources, and update resources if ids are given for input and output resources. Destroy resources if ids of existing resources are not givens.<br/>" \
      "<br/>" \
      "`span_in_days` is optional, and automatically filled with default value for both input and output resources.<br/>" \
      "`consumable` for input resources are automatically set to true because this job will consume events for the input resource.<br/>" \
      "`notifiable` for output resources should be set to 'true' only if the registered job will notify the end of job to triglav (i.e, send messages directly without triglav agent).<br/>"
    end

    describe "Create a job" do

      let(:job) do
        FactoryGirl.build(:job)
      end

      let(:input_resources) do
        [
          FactoryGirl.build(:resource, uri: "resource://input/uri/0"),
          FactoryGirl.build(:resource, uri: "resource://input/uri/1"),
        ]
      end

      let(:output_resources) do
        [
          FactoryGirl.build(:resource, uri: "resource://output/uri/0"),
          FactoryGirl.build(:resource, uri: "resource://output/uri/1", notifiable: true),
        ]
      end

      let(:input_resource_params) do
        %w[description uri unit timezone]
      end

      let(:output_resource_params) do
        %w[description uri unit timezone notifiable]
      end

      let(:params) do
        job.attributes.except('created_at', 'updated_at').merge({
          input_resources: input_resources.map {|r| r.attributes.slice(*input_resource_params) },
          output_resources: output_resources.map {|r| r.attributes.slice(*output_resource_params) },
        })
      end

      it "PUT/PATCH /api/v1/jobs", :autodoc do

        put "/api/v1/jobs", params: params.to_json, env: env

        expect(response.status).to eq 200
        expect(Job.all.size).to eq(1)
        expect(JobsInputResource.all.size).to eq(2)
        expect(JobsOutputResource.all.size).to eq(2)
        expect(Resource.all.size).to eq(4)

      end
    end

    describe "Update a job" do

      let(:job) do
        FactoryGirl.create(:job)
      end

      let(:input_resources) do
        [
          FactoryGirl.create(:resource, uri: "resource://input/uri/0"),
          FactoryGirl.create(:resource, uri: "resource://input/uri/1"),
        ]
      end

      let(:output_resources) do
        [
          FactoryGirl.create(:resource, uri: "resource://output/uri/0"),
          FactoryGirl.create(:resource, uri: "resource://output/uri/1"),
        ]
      end

      let(:params) do
        job.attributes.merge({
          input_resources: input_resources.map {|r| r.attributes.slice(*ResourceSerializer.request_permit_params.map(&:to_s)) },
          output_resources: output_resources.map {|r| r.attributes.slice(*ResourceSerializer.request_permit_params.map(&:to_s)) },
        })
      end

      it "PUT/PATCH /api/v1/jobs" do

        put "/api/v1/jobs", params: params.to_json, env: env

        expect(response.status).to eq 200
        expect(Job.all.size).to eq(1)
        expect(JobsInputResource.all.size).to eq(2)
        expect(JobsOutputResource.all.size).to eq(2)
        expect(Resource.all.size).to eq(4)

      end
    end
  end

  describe "Get a job" do

    let(:description) do
      "Get a job<br/>"
    end

    it "GET /api/v1/jobs/:id_or_uri" do

      get "/api/v1/jobs/#{job.id}", params: params, env: env

      expect(response.status).to eq 200

    end

    it "GET /api/v1/jobs/:id_or_uri", :autodoc do

      get "/api/v1/jobs/#{CGI.escape(job.uri)}", params: params, env: env

      expect(response.status).to eq 200

    end
  end

  describe "Delete a job", :autodoc do

    let(:description) do
      "Delete a job"
    end

    let(:job) do
      FactoryGirl.create(:job)
    end

    it "DELETE /api/v1/jobs/:job_id" do

      delete "/api/v1/jobs/#{job.id}", params: params, env: env

      expect(response.status).to eq 204
      
    end
  end

end
