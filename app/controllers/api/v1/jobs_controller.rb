module Api
  module V1
    class JobsController < ApplicationController
      include Swagger::Blocks

      # GET /jobs
      # GET /jobs.json
      swagger_path '/jobs' do
        operation :get do
          key :description, 'Returns all jobs'
          key :operationId, 'listJobs'
          key :tags, ['jobs']
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'job response'
            schema do
              key :type, :array
              items do
                key :'$ref', :JobEachResponse
              end
            end
          end
          response :unprocessable_entity do
            key :description, 'unexpected error'
            schema do
              key :'$ref', :ErrorModel
            end
          end
        end
      end

      # GET /jobs
      # GET /jobs.json
      def index
        @jobs = Job.all
        render json: @jobs, each_serializer: JobEachSerializer
      end

      # GET /jobs/1
      # GET /jobs/1.json
      swagger_path '/jobs/{id_or_uri}' do
        operation :get do
          key :description, 'Returns a single job'
          key :operationId, 'getJob'
          key :tags, ['jobs']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :id_or_uri
            key :in, :path
            key :description, 'ID or URI of job to fetch'
            key :required, true
            key :type, :string
          end
          response 200 do
            key :description, 'job response'
            schema do
              key :'$ref', :JobResponse
            end
          end
          response :default do
            key :description, 'unexpected error'
            schema do
              key :'$ref', :ErrorModel
            end
          end
        end
      end

      # GET /jobs/1
      # GET /jobs/1.json
      def show
        set_job!
        render json: @job
      end

      # PATCH/PUT /jobs
      # PATCH/PUT /jobs.json
      swagger_path '/jobs' do
        operation :patch do
          key :description, 'Creates or Updates a single job'
          key :operationId, 'createOrUpdateJob'
          key :tags, ['jobs']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :job
            key :in, :body
            key :description, 'Job parameters'
            key :required, true
            schema do
              key :'$ref', :JobRequest
            end
          end
          response 200 do
            key :description, 'job response'
            schema do
              key :'$ref', :JobResponse
            end
          end
          response :default do
            key :description, 'unexpected error'
            schema do
              key :'$ref', :ErrorModel
            end
          end
        end
      end

      # PATCH/PUT /jobs
      # PATCH/PUT /jobs.json
      def update
        @job = Job.create_or_update_with_resources!(job_params)
        render json: @job
      end

      # DELETE /jobs/1
      # DELETE /jobs/1.json
      swagger_path '/jobs/{id_or_uri}' do
        operation :delete do
          key :description, 'Deletes single job'
          key :operationId, 'deleteJob'
          key :tags, ['jobs']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :id_or_uri
            key :in, :path
            key :description, 'ID or URI of job to fetch'
            key :required, true
            key :type, :string
          end
          response 204 do
            key :description, 'deleted'
          end
          response :default do
            key :description, 'unexpected error'
            schema do
              key :'$ref', :ErrorModel
            end
          end
        end
      end

      # DELETE /jobs/1
      # DELETE /jobs/1.json
      def destroy
        set_job! rescue nil
        @job.destroy_with_resources! if @job
        head :no_content
      end

      private

      def set_job!
        begin
          @job = Job.find(Integer(params[:id_or_uri]))
        rescue
          @job = Job.find_by!(uri: params[:id_or_uri])
        end
      end

      def job_params
        JobSerializer.request_params(params)
      end

    end
  end
end
