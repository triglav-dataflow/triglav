FactoryGirl.define do
  factory :job do
    uri "http://localhost/path/to/job?query=parameter"
  end

  factory :job_with_resources, parent: :job do

    after(:create) do |job|
      2.times do |i|
        resource = create(:resource, uri: "resource://input/uri/#{i}")
        JobsInputResource.create(job_id: job.id, resource_id: resource.id)
      end

      2.times do |i|
        resource = create(:resource, uri: "resource://output/uri/#{i}")
        JobsOutputResource.create(job_id: job.id, resource_id: resource.id)
      end
    end

  end
end
