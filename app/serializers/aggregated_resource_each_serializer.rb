class AggregatedResourceEachSerializer < ActiveModel::Serializer
  attributes :uri, :unit, :timezone, :span_in_days

  include Swagger::Blocks

  swagger_schema :AggregatedResourceEachResponse do
    property :uri do
      key :type, :string
      key :description, "resource uri"
    end
    property :unit do
      key :type, :string
      key :description, "'singular' or 'daily' or 'hourly', or their combinations such as 'daily,hourly', 'daily,hourly,singular'"
    end
    property :timezone do
      key :type, :string
      key :description, "timezone of the format [+-]HH:MM"
    end
    property :span_in_days do
      key :type, :integer
      key :description, "span in days"
    end
  end
end
