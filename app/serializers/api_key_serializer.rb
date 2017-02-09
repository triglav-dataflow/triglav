class ApiKeySerializer < ActiveModel::Serializer
  attributes :access_token, :expires_at

  include Swagger::Blocks

  swagger_schema :"Credential", required: [:username, :password] do
    property :username do
      key :type, :string
    end
    property :password do
      key :type, :string
    end
    property :authenticator do
      key :type, :string
      key :enum, ['local']
    end
  end

  swagger_schema :TokenResponse do
    property :access_token do
      key :type, :string
    end
    property :expires_at do
      key :type, :string
      key :format, :"date-time"
    end
  end

end

