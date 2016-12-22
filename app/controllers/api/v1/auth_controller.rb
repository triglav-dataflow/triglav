module Api
  module V1
    class AuthController < ApplicationController
      include Swagger::Blocks

      before_action :authenticate!, only: [:destroy, :me]

      swagger_path '/auth/token' do
        operation :post do
          key :description, 'Creates a new token'
          key :operationId, 'createToken'
          key :tags, ['auth']
          parameter do
            key :name, :credential
            key :in, :body
            key :required, true
            schema do
              key :'$ref', :Credential
            end
          end
          response 200 do
            key :description, 'access token response'
            schema do
              key :'$ref', :TokenResponse
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

      def create
        user = User.authenticate(sign_in_params)
        api_key = ApiKey.create(user_id: user.id) if user
        if user and api_key
          self.current_user = user
          render json: api_key
        else
          raise Triglav::Error::InvalidAuthenticityCredential
        end
      end

      swagger_path '/auth/token' do
        operation :delete do
          key :description, 'Deletes (Expires) a token of header'
          key :operationId, 'deleteToken'
          key :tags, ['auth']
          security do
            key :api_key, []
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

      def destroy
        self.current_user = nil
        ApiKey.find_by(access_token: current_access_token).try(:destroy)
        head :no_content
      end

      swagger_path '/auth/me' do
        operation :get do
          key :description, 'Returns a user property of the access_token'
          key :operationId, 'me'
          key :tags, ['auth']
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'user response'
            schema do
              key :'$ref', :UserResponse
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

      def me
        render json: current_user
      end

      private

      def sign_in_params
        params.require(:username)
        params.require(:password)
        params.permit(:username, :password, :authenticator)
      end
    end
  end
end
