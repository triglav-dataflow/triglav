module Api
  module V1
    class JobMessagesController < ApplicationController
      include Swagger::Blocks

      # GET /job_messages
      # GET /job_messages.json
      #
      # MEMO: Query can not use schema type
      swagger_path '/job_messages' do
        operation :get do
          key :description, 'Fetch Job messages'
          key :operationId, 'fetchJobMessages'
          key :tags, ['jobMessages']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :offset
            key :in, :query
            key :description, 'Offset (Greater than or equal to) ID for Messages to fetch from'
            key :required, true
            key :type, :integer
            key :format, :int64
          end
          parameter do
            key :name, :limit
            key :in, :query
            key :description, 'Number of limits'
            key :required, false
            key :type, :integer
            key :format, :int64
          end
          parameter do
            key :name, :job_id
            key :in, :query
            key :description, 'Job ID'
            key :required, true
            key :type, :integer
            key :format, :int64
          end
          response 200 do
            key :description, 'message response'
            schema do
              key :type, :array
              items do
                key :'$ref', :JobMessageEachResponse
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

      # GET /job_messages
      # GET /job_messages.json
      def index
        @messages = JobMessage.where("id >= ?", params.require(:offset))
        @messages = @messages.where(job_id: params.require(:job_id))
        @messages = @messages.order(id: :asc)
        @messages = @messages.limit(params[:limit] || 100)
        render json: @messages, each_serializer: JobMessageEachSerializer
      end

      swagger_path '/job_messages/last_id' do
        operation :get do
          key :description, 'Get the current last message id which would be used as a first offset to fetch messages'
          key :operationId, 'getLastJobMessageId'
          key :tags, ['jobMessages']
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'last message id response'
            schema do
              key :'$ref', :LastJobMessageIdResponse
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

      swagger_schema :LastJobMessageIdResponse do
        property :id do
          key :description, 'last message id'
          key :type, :integer
          key :format, :int64
        end
      end

      def last_id
        last_id = JobMessage.last&.id || 0
        render json: {id: last_id}
      end
    end
  end
end
