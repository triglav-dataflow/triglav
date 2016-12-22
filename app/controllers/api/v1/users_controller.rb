## We may not need this
module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate!
      # before_action :admin!
      before_action :check_authenticator!, only: [:create, :update]

      include Swagger::Blocks

      swagger_path '/users' do
        operation :get do
          key :description, 'Returns all users from the system that the user has access to'
          key :operationId, 'listUsers'
          key :tags, ['users']
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'user response'
            schema do
              key :type, :array
              items do
                key :'$ref', :UserEachResponse
              end
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

      def index
        @users = User.all
        render json: @users, each_serializer: UserEachSerializer
      end

      swagger_path '/users/{id}' do
        operation :get do
          key :description, 'Returns a single user'
          key :operationId, 'getUser'
          key :tags, ['users']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :id
            key :in, :path
            key :description, 'ID of user to fetch'
            key :required, true
            key :type, :integer
            key :format, :int64
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

      def show
        set_user!
        render json: @user
      end

      swagger_path '/users' do
        operation :post do
          key :description, 'Creates a new user in the store'
          key :operationId, 'createUser'
          key :tags, ['users']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :user
            key :in, :body
            key :description, 'User to add to the store'
            key :required, true
            schema do
              key :'$ref', :UserRequest
            end
          end
          response 201 do
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

      def create
        @user = User.new(user_create_params)

        if @user.save
          render json: @user, status: 201
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
      
      swagger_path '/users/{id}' do
        operation :patch do
          key :description, 'Updates a single user'
          key :operationId, 'updateUser'
          key :tags, ['users']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :id
            key :in, :path
            key :description, 'ID of user to fetch'
            key :required, true
            key :type, :integer
            key :format, :int64
          end
          parameter do
            key :name, :user
            key :in, :body
            key :description, 'User parameters to update'
            key :required, true
            schema do
              key :'$ref', :UserRequest
            end
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

      def update
        set_user!
        if @user.update(user_update_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      swagger_path '/users/{id}' do
        operation :delete do
          key :description, 'Deletes single user'
          key :operationId, 'deleteUser'
          key :tags, ['users']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :id
            key :in, :path
            key :description, 'ID of user to fetch'
            key :required, true
            key :type, :integer
            key :format, :int64
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
        set_user!
        @user.destroy!
        head :no_content
      end

      private

      def set_user!
        @user = User.find(params[:id])
      end

      def user_create_params
        params.permit(
          :name,
          :description,
          :authenticator,
          :password,
          :email,
          :groups => [],
        )
      end

      def user_update_params
        params.permit(
          :description,
          :authenticator,
          :password,
          :email,
          :groups => [],
        )
      end

      def check_authenticator!
        unless params[:authenticator] == 'local'
          raise Triglav::Error::BadRequest, 'Invalid authenticator'
        end
      end
    end
  end
end
