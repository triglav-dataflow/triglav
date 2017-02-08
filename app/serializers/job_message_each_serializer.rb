class JobMessageEachSerializer < ActiveModel::Serializer
  attributes :id,
    :job_id,
    :time,
    :timezone

  include Swagger::Blocks

  swagger_schema :JobMessageEachResponse do
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :job_id do
      key :type, :integer
      key :description, 'Job ID'
    end
    property :time do
      key :type, :integer
      key :description, 'Time of event in unix timestamp such as 1476025200 (2016-10-10 in +09:00)'
    end
    property :timezone do
      key :type, :string
      key :description, 'Timezone of event time, that is, timezone of %Y-%m-%d for hdfs://path/to/%Y-%m-%d such as +09:00'
    end
  end

end
