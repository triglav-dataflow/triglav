class ResourceSerializer < ActiveModel::Serializer
  attributes :id,
    :description,
    :uri,
    :unit,
    :timezone,
    :span_in_days,
    :consumable,
    :notifiable,
    :created_at,
    :updated_at

  def self.request_params(params)
    params.require(:uri)
    params.require(:unit)
    params.permit(*request_permit_params)
  end

  def self.request_permit_params
    [
      :id,
      :description,
      :uri,
      :unit,
      :timezone,
      :span_in_days,
      :consumable,
      :notifiable
    ]
  end

  include Swagger::Blocks

  swagger_schema :ResourceResponse do
    allOf do
      schema do
        key :'$ref', :ResourceRequest
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
      end
    end
  end

  swagger_schema :ResourceRequest, required: [:uri] do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :description do
      key :type, :string
    end
    property :uri do
      key :type, :string
      key :description, 'URI of Resource'
    end
    property :unit do
      key :type, :string
      key :description, 'Time unit of resource to monitor such as singular, daily, or hourly'
    end
    property :timezone do
      key :type, :string
      key :description, 'Timezone of resource time, that is, timezone of %Y-%m-%d for hdfs://path/to/%Y-%m-%d such as +09:00'
    end
    property :span_in_days do
      key :type, :integer
      key :description, 'Time span of resource to monitor, default is 32'
    end
    property :consumable do
      key :type, :boolean
      key :description, 'True if this resource should be consumed. Input resources are automatically set to true, and output resources are set to false'
    end
    property :notifiable do
      key :type, :boolean
      key :description, 'True if a job notifies its end of task to triglav for this resource, that is, monitoring in agent is not necessary'
    end
  end

end
