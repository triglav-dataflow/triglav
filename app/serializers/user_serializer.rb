class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :authenticator, :groups, :email, :created_at, :updated_at

  include Swagger::Blocks

  swagger_schema :UserResponse, required: [:id, :name] do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :description do
      key :type, :string
    end
    property :authenticator do
      key :type, :string
      key :description, 'local or ldap'
      key :enum, ['local', 'ldap']
    end
    property :groups do
      key :type, :array
      items do
        key :type, :string
      end
    end
    property :email do
      key :type, :string
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

  swagger_schema :UserRequest do
    # allOf do
    #   schema do
    #     key :'$ref', :User
    #   end
    #   schema do
    #     key :required, [:name]
    #     property :password do
    #       key :type, :string
    #     end
    #   end
    # end
    property :name do
      key :type, :string
    end
    property :description do
      key :type, :string
    end
    property :authenticator do
      key :type, :string
      key :description, 'local or ldap'
      key :enum, ['local', 'ldap']
    end
    property :groups do
      key :type, :array
      items do
        key :type, :string
      end
    end
    property :email do
      key :type, :string
    end
    property :password do
      key :type, :string
    end
  end

end
