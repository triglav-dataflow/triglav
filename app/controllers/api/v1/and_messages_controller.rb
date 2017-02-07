module Api
  module V1
    class AndMessagesController < ApplicationController
      include Swagger::Blocks

      # GET /and_messages
      # GET /and_messages.json
      #
      # MEMO: Query can not use schema type
      swagger_path '/and_messages' do
        operation :get do
          key :description, 'Fetch AND messages'
          key :operationId, 'fetchAndMessages'
          key :tags, ['andMessages']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :offset
            key :in, :query
            key :description, 'Offset (Greater than or equal to) ID for Messages to fetch from'
            key :required, true
            key :type, :integer
          end
          parameter do
            key :name, :limit
            key :in, :query
            key :description, 'Number of limits'
            key :required, false
            key :type, :integer
          end
          parameter do
            key :name, :job_id
            key :in, :query
            key :description, 'Job ID'
            key :required, true
            key :type, :integer
          end
          response 200 do
            key :description, 'message response'
            schema do
              key :type, :array
              items do
                key :'$ref', :AndMessageEachResponse
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

      # GET /and_messages
      # GET /and_messages.json
      def index
        @messages = AndMessage.where("id >= ?", params.require(:offset))
        @messages = @messages.where(job_id: params.require(:job_id))
        @messages = @messages.order(id: :asc)
        @messages = @messages.limit(params[:limit] || 100)
        render json: @messages, each_serializer: AndMessageEachSerializer
      end

      swagger_path '/and_messages/last_id' do
        operation :get do
          key :description, 'Get the current last message id which would be used as a first offset to fetch messages'
          key :operationId, 'getLastAndMessageId'
          key :tags, ['andMessages']
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'last message id response'
            schema do
              key :'$ref', :LastAndMessageIdResponse
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

      swagger_schema :LastAndMessageIdResponse do
        property :id do
          key :description, 'last message id'
          key :type, :integer
        end
      end

      def last_id
        last_id = AndMessage.last&.id || 0
        render json: {id: last_id}
      end
    end
  end
end
