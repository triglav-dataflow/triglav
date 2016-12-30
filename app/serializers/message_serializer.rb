class MessageSerializer < ActiveModel::Serializer
  attributes :id,
    :resource_uri,
    :resource_unit,
    :resource_time,
    :resource_timezone,
    :payload,
    :created_at,
    :updated_at

  def self.request_params(params)
    params.permit(*request_permit_params)
  end

  def self.request_permit_params
    [
      :resource_uri,
      :resource_unit,
      :resource_time,
      :resource_timezone,
      :payload
    ]
  end

  include Swagger::Blocks

  swagger_schema :MessageResponse do
    allOf do
      schema do
        key :'$ref', :MessageRequest
      end
      schema do
        property :id do
          key :type, :integer
          key :format, :int64
        end
        property :created_at do
          key :type, :string
          key :format, :"date-time"
        end
        property :updated_at do
          key :type, :string
          key :format, :"date-time"
        end
      end
    end
  end

  swagger_schema :MessageRequest, required: [
    :resource_uri,
    :resource_unit,
    :resource_time,
    :resource_timezone] do
    property :resource_uri do
      key :type, :string
      key :description, 'URI of Resource'
    end
    property :resource_unit do
      key :type, :string
      key :description, 'Time unit of resource to monitor such as daily, or hourly'
    end
    property :resource_time do
      key :type, :integer
      key :description, 'Time of Resource in unix timestamp such as 1476025200 (2016-10-10 in +09:00)'
    end
    property :resource_timezone do
      key :type, :string
      key :description, 'Timezone of resource time, that is, timezone of %Y-%m-%d for hdfs://path/to/%Y-%m-%d such as +09:00'
    end
    # Swagger supports only fixed data type, and does not support flexible json data type
    # To support flexible json type, we receive a json *string* and parse it in inside
    property :payload do
      key :type, :string
      key :description, 'Any json string'
    end
  end

end
