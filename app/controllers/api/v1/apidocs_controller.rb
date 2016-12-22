module Api
  module V1
    class ApidocsController < ApplicationController

      SWAGGERED_CLASSES = [
        self,
        Api::V1::AuthController,
        ApiKeySerializer,
        JobSerializer,
        JobEachSerializer,
        Api::V1::JobsController,
        MessageSerializer,
        MessageEachSerializer,
        Api::V1::MessagesController,
        ResourceSerializer,
        ResourceEachSerializer,
        AggregatedResourceEachSerializer,
        Api::V1::ResourcesController,
        UserSerializer,
        UserEachSerializer,
        Api::V1::UsersController
      ].freeze

      include Swagger::Blocks

      swagger_root do
        key :swagger, '2.0'
        info version: '1.0.0' do
          key :title, 'Triglav API'
          key :description, 'Triglav API Reference'
          contact do
            key :name, 'Triglav Team'
            key :email, 'triglav_admin_my@dena.jp'
          end
          license do
            key :name, 'MIT'
          end
        end
        key :basePath, '/api/v1'
        key :schemes, ['http', 'https']
        key :consumes, ['application/json']
        key :produces, ['application/json']
        security_definition :api_key, type: :apiKey do
          key :name, 'Authorization'
          key :in, 'header'
        end
        tag name: 'triglav' do
          key :description, 'Triglav operations'
          externalDocs description: 'Find more info here' do
            key :url, 'https://triglav.github.io'
          end
        end
      end

      swagger_schema :ErrorModel do
        key :required, [:error, :backtrace]
        property :error do
          key :type, :string
        end
        property :backtrace do
          key :type, :array
          items do
            key :type, :string
          end
        end
      end

      def index
        render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
      end
    end
  end
end
