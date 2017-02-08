module Api
  module V1
    class MessagesController < ApplicationController
      include Swagger::Blocks

      # GET /messages
      # GET /messages.json
      #
      # MEMO: Query can not use schema type
      swagger_path '/messages' do
        operation :get do
          key :description, 'Fetch messages'
          key :operationId, 'fetchMessages'
          key :tags, ['messages']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :offset
            key :in, :query
            key :description, 'Offset (Greater than or equal to) ID for Messages to list from'
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
            key :name, :resource_uris
            key :in, :query
            key :description, 'URIs of Resource'
            key :required, false
            schema do
              key :type, :array
              items do
                key :type, :string
              end
            end
          end
          response 200 do
            key :description, 'message response'
            schema do
              key :type, :array
              items do
                key :'$ref', :MessageEachResponse
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

      # GET /messages
      # GET /messages.json
      def index
        @messages = Message.where("id >= ?", params.require(:offset))
        if params[:resource_uris].present?
          case params[:resource_uris]
          when ActionController::Parameters
            # swagger client passes an array value as a hash like {"0"=>val} in query parameter
            @messages = @messages.where(resource_uri: params[:resource_uris].to_unsafe_h.values)
          else
            @messages = @messages.where(resource_uri: params[:resource_uris])
          end
        end
        @messages = @messages.order(id: :asc)
        @messages = @messages.limit(params[:limit] || 100)
        render json: @messages, each_serializer: MessageEachSerializer
      end

      # POST /messages
      # POST /messages.json
      swagger_path '/messages' do
        operation :post do
          key :description, 'Enqueues new messages'
          key :operationId, 'sendMessages'
          key :tags, ['messages']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :messages
            key :in, :body
            key :description, 'Messages to enqueue'
            key :required, true
            schema do
              key :type, :array
              items do
                key :'$ref', :MessageRequest
              end
            end
          end
          response 201 do
            key :description, 'bulkinsert response'
            schema do
              key :'$ref', :BulkinsertResponse
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

      swagger_schema :BulkinsertResponse do
        property :num_inserts do
          key :description, 'Number of inserts'
          key :type, :integer
        end
      end

      # POST /messages
      # POST /messages.json
      def create
        begin
          result = Message.create_messages(messages_params)
          render json: {num_inserts: result[:num_inserts]}
        rescue ActiveRecord::StatementInvalid => e
          render json: {error: "#{e.class} #{e.message}", backtrace: e.backtrace}, status: :unprocessable_entity
        end
      end

      swagger_path '/messages/last_id' do
        operation :get do
          key :description, 'Get the current last message id which would be used as a first offset to fetch messages'
          key :operationId, 'getLastMessageId'
          key :tags, ['messages']
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'last message id response'
            schema do
              key :'$ref', :LastMessageIdResponse
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

      swagger_schema :LastMessageIdResponse do
        property :id do
          key :description, 'last message id'
          key :type, :integer
        end
      end

      def last_id
        last_id = Message.last&.id || 0
        render json: {id: last_id}
      end

      private

      def messages_params
        params.permit(_json: MessageSerializer.request_permit_params)[:_json]
      end
    end
  end
end
