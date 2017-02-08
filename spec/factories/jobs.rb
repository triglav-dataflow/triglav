FactoryGirl.define do
  factory :job do
    uri "http://localhost/path/to/job?query=parameter"
    logical_op "or"
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

  factory :job_with_or_resources, parent: :job_with_resources do
    logical_op "or"
  end

  factory :job_with_and_resources, parent: :job_with_resources do
    logical_op "and"
  end

  factory :job_with_single_resource, parent: :job do

    after(:create) do |job|
      1.times do |i|
        resource = create(:resource, uri: "resource://input/uri/#{i}")
        JobsInputResource.create(job_id: job.id, resource_id: resource.id)
      end

      1.times do |i|
        resource = create(:resource, uri: "resource://output/uri/#{i}")
        JobsOutputResource.create(job_id: job.id, resource_id: resource.id)
      end
    end

  end

end
