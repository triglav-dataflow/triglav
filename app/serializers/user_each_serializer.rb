class UserEachSerializer < ActiveModel::Serializer
  attributes :id, :name, :authenticator, :email

  include Swagger::Blocks

  swagger_schema :UserEachResponse, required: [:id, :name] do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :authenticator do
      key :type, :string
      key :description, 'local or ldap'
      key :enum, ['local', 'ldap']
    end
    property :email do
      key :type, :string
    end
  end
end
