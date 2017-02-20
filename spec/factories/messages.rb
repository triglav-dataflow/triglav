require 'securerandom'

FactoryGirl.define do
  factory :message do
    uuid SecureRandom.uuid
    resource_uri "hdfs://localhost/path/to/file.csv.gz"
    resource_unit "daily"
    resource_time 1467298800 # "2016-07-01" in +09:00
    resource_timezone "+09:00"
    payload '{"foo":"bar"}'
  end
end
