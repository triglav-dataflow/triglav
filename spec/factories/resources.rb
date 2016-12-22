FactoryGirl.define do
  factory :resource do
    description "MyString"
    uri "hdfs://localhost/path/to/file.csv.gz"
    unit "daily"
    timezone "+09:00"
    span_in_days nil
    consumable true
    notifiable false
  end
end
