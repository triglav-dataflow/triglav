class ResourceEachSerializer < ActiveModel::Serializer
  attributes :uri, :unit, :timezone, :span_in_days, :consumable, :notifiable

  include Swagger::Blocks

  swagger_schema :ResourceEachResponse do
    allOf do
      schema do
        key :'$ref', :AggregatedResourceEachResponse
      end
      schema do
        property :unit do
          key :type, :string
          key :description, "'singualr' or 'daily' or 'hourly'"
        end
        property :consumable do
          key :type, :boolean
          key :description, 'True if this resource should be consumed'
        end
        property :notifiable do
          key :type, :boolean
          key :description, 'True if a job notifies its end of task to triglav for this resource, that is, monitoring in agent is not necessary'
        end
      end
    end
  end
end
