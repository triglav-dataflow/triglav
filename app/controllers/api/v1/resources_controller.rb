module Api
  module V1
    class ResourcesController < ApplicationController
      include Swagger::Blocks

      # GET /aggregated_resources
      # GET /aggregated_resources.json
      swagger_path '/aggregated_resources' do
        operation :get do
          key :description, 'Returns aggregated resources to be monitored'
          key :operationId, 'listAggregatedResources'
          key :tags, ['resources']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :uri_prefix
            key :in, :query
            key :description, 'Prefix of Resource URI'
            key :required, true
            key :type, :string
          end
          response 200 do
            key :description, 'resource response'
            schema do
              key :type, :array
              items do
                key :'$ref', :AggregatedResourceEachResponse
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

      # GET /aggregated_resources
      # GET /aggregated_resources.json
      def aggregated_resources
        # @todo: Using materialized view is better (In mysql, insert select with trigger)
        #
        # EXAMPLE:
        # uri       unit    span_in_days consumable notifiable
        # hdfs://a  hourly  10           true       false
        # hdfs://a  daily   32           true       false
        # hdfs://b  hourly  32           true       false
        # hdfs://b  hourly  32           true       true
        #
        # non_notifiable_uris =>
        # ['hdfs://a']
        #
        # aggregated_resources =>
        # uri       unit         span_in_days
        # hdfs://a  daily,hourly 32

        non_notifiable_uris = Resource.
          where('uri LIKE ?', "#{params.require(:uri_prefix)}%").
          group('uri').
          having('BIT_OR(notifiable) = false').
          pluck('uri')

        aggregated_resources = Resource.
          select('uri, GROUP_CONCAT(DISTINCT(unit) order by unit) AS unit, timezone, MAX(span_in_days) AS span_in_days').
          where(uri: non_notifiable_uris).
          where(consumable: true).
          group('uri', 'timezone').
          order('uri')

        render json: aggregated_resources, each_serializer: AggregatedResourceEachSerializer
      end

      # GET /resources
      # GET /resources.json
      swagger_path '/resources' do
        operation :get do
          key :description, 'Returns all resources'
          key :operationId, 'listResources'
          key :tags, ['resources']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :uri_prefix
            key :in, :query
            key :description, 'Prefix of Resource URI'
            key :required, false
            key :type, :string
          end
          response 200 do
            key :description, 'resource response'
            schema do
              key :type, :array
              items do
                key :'$ref', :ResourceEachResponse
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

      # GET /resources
      # GET /resources.json
      def index
        params.permit(:uri_prefix)
        if uri_prefix = params[:uri_prefix]
          @resources = Resource.where('uri LIKE ?', "#{uri_prefix}%")
        else
          @resources = Resource.all
        end
        render json: @resources, each_serializer: ResourceEachSerializer
      end

      # GET /resources/1
      # GET /resources/1.json
      swagger_path '/resources/{id_or_uri}' do
        operation :get do
          key :description, 'Returns a single resource'
          key :operationId, 'getResource'
          key :tags, ['resources']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :id_or_uri
            key :in, :path
            key :description, 'ID or URI of resource to fetch'
            key :required, true
            key :type, :string
          end
          response 200 do
            key :description, 'resource response'
            schema do
              key :'$ref', :ResourceResponse
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

      # GET /resources/1
      # GET /resources/1.json
      def show
        set_resource!
        render json: @resource
      end

      # POST /resources
      # POST /resources.json
      swagger_path '/resources' do
        operation :post do
          key :description, 'Creates a new resource'
          key :operationId, 'createResource'
          key :tags, ['resources']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :resource
            key :in, :body
            key :description, 'Resource to add'
            key :required, true
            schema do
              key :'$ref', :ResourceRequest
            end
          end
          response 201 do
            key :description, 'resource response'
            schema do
              key :'$ref', :ResourceResponse
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

      # POST /resources
      # POST /resources.json
      def create
        @resource = Resource.new(resource_params)

        if @resource.save
          render json: @resource
        else
          render json: @resource.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /resources
      # PATCH/PUT /resources.json
      swagger_path '/resources/{id_or_uri}' do
        operation :patch do
          key :description, 'Updates a single resource'
          key :operationId, 'updateResource'
          key :tags, ['resources']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :id_or_uri
            key :in, :path
            key :description, 'ID or URI of resource to fetch'
            key :required, true
            key :type, :string
          end
          parameter do
            key :name, :resource
            key :in, :body
            key :description, 'Resource parameters to update'
            key :required, true
            schema do
              key :'$ref', :ResourceRequest
            end
          end
          response 200 do
            key :description, 'resource response'
            schema do
              key :'$ref', :ResourceResponse
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

      # PATCH/PUT /resources
      # PATCH/PUT /resources.json
      def update
        set_resource!

        if @resource.update(resource_params)
          render json: @resource
        else
          render json: @resource.errors, status: :unprocessable_entity
        end
      end

      # DELETE /resources/1
      # DELETE /resources/1.json
      swagger_path '/resources/{id_or_uri}' do
        operation :delete do
          key :description, 'Deletes single resource'
          key :operationId, 'deleteResource'
          key :tags, ['resources']
          security do
            key :api_key, []
          end
          parameter do
            key :name, :id_or_uri
            key :in, :path
            key :description, 'ID or URI of resource to fetch'
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

      # DELETE /resources/1
      # DELETE /resources/1.json
      def destroy
        set_resource!
        @resource.destroy
        head :no_content
      end

      private

      def set_resource!
        begin
          @resource = Resource.find(Integer(params[:id_or_uri]))
        rescue
          @resource = Resource.find_by!(uri: params[:id_or_uri])
        end
      end

      def as_boolean(query_param)
        return true  if %w[1 true].include?(query_param)
        return false if %w[0 false].include?(query_param)
        query_param
      end

      def resource_params
        ResourceSerializer.request_params(params)
      end
    end
  end
end
