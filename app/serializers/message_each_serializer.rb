class MessageEachSerializer < ActiveModel::Serializer
  attributes :id,
    :resource_uri,
    :resource_unit,
    :resource_time,
    :resource_timezone,
    :payload,
    :created_at,
    :updated_at

  include Swagger::Blocks

  swagger_schema :MessageEachResponse do
    allOf do
      schema do
        key :'$ref', :MessageResponse
      end
    end
  end

  swagger_schema :MessageFetchRequest, required: [:offset] do
    property :offset do
      key :type, :integer
      key :format, :int64
      key :description, 'Offset (Greater than or equal to) ID for Messages to fetch from'
    end
    property :limit do
      key :type, :integer
      key :format, :int64
      key :description, 'Number of limits'
    end
    property :resource_uris do
      key :type, :array
      key :description, 'URIs of Resource'
      items do
        key :type, :string
      end
    end
  end

end
