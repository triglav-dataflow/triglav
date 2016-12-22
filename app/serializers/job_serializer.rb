class JobSerializer < ActiveModel::Serializer
  attributes :id, :uri, :created_at, :updated_at
  has_many :input_resources
  has_many :output_resources

  def self.request_params(params)
    params.permit(
      :id, :uri,
      input_resources: ResourceSerializer.request_permit_params,
      output_resources: ResourceSerializer.request_permit_params,
    )
  end

  include Swagger::Blocks

  swagger_schema :JobResponse do
    allOf do
      schema do
        key :'$ref', :JobRequest
      end
      schema do
        property :created_at do
          key :type, :string
          key :format, :"date-time"
        end
        property :updated_at do
          key :type, :string
          key :format, :"date-time"
        end
        property :input_resources do
          key :type, :array
          key :description, 'Input resources'
          items do
            key :'$ref', :ResourceResponse
          end
        end
        property :output_resources do
          key :type, :array
          key :description, 'Output resources'
          items do
            key :'$ref', :ResourceResponse
          end
        end
      end
    end
  end

  swagger_schema :JobRequest do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :uri do
      key :type, :string
    end
    property :input_resources do
      key :type, :array
      key :description, 'New resources are created if id is not given. Update if id is given'
      items do
        key :'$ref', :ResourceRequest
      end
    end
    property :output_resources do
      key :type, :array
      key :description, 'New resources are created if id is not given. Update if id is given'
      items do
        key :'$ref', :ResourceRequest
      end
    end
  end

end
