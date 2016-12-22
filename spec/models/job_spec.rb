require 'rails_helper'

RSpec.describe Job, type: :model do

  describe '#create_or_update_with_resources!' do
    context 'create a new job' do
      let(:params) do
        FactoryGirl.build(:job).attributes.except('id').merge({
          'input_resources' => [
            FactoryGirl.build(:resource, uri: "resource://input/uri/0", unit: "daily").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://input/uri/1", unit: "daily").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://input/uri/0", unit: "hourly").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://input/uri/1", unit: "hourly").attributes.except('id'),
          ],
          'output_resources' => [
            FactoryGirl.build(:resource, uri: "resource://output/uri/0", unit: "daily").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://output/uri/1", unit: "daily").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://output/uri/0", unit: "hourly").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://output/uri/1", unit: "hourly").attributes.except('id'),
          ]
        })
      end

      it do
        job = Job.create_or_update_with_resources!(params)
        expect(job.uri).to eql(params['uri'])
        expect(JobsInputResource.all.size).to eql(4)
        expect(JobsOutputResource.all.size).to eql(4)
        expect(Resource.all.size).to eql(8)
      end
    end

    context 'update a job and append resources' do
      let(:job) do
        FactoryGirl.create(:job)
      end

      let(:params) do
        job.attributes.merge({
          'input_resources' => [
            FactoryGirl.build(:resource, uri: "resource://input/uri/0", unit: "daily").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://input/uri/1", unit: "daily").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://input/uri/0", unit: "hourly").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://input/uri/1", unit: "hourly").attributes.except('id'),
          ],
          'output_resources' => [
            FactoryGirl.build(:resource, uri: "resource://output/uri/0", unit: "daily").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://output/uri/1", unit: "daily").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://output/uri/0", unit: "hourly").attributes.except('id'),
            FactoryGirl.build(:resource, uri: "resource://output/uri/1", unit: "hourly").attributes.except('id'),
          ]
        })
      end

      it do
        Job.create_or_update_with_resources!(params)
        expect(job.uri).to eql(params['uri'])
        expect(JobsInputResource.all.size).to eql(4)
        expect(JobsOutputResource.all.size).to eql(4)
        expect(Resource.all.size).to eql(8)
      end
    end

    context 'update a job and update resources' do
      let(:job) do
        FactoryGirl.create(:job_with_resources)
      end

      let(:params) do
        job.attributes.merge({
          'input_resources' => job.input_resources.map {|r| r.attributes.merge('unit'=>'hourly') },
          'output_resources' => job.output_resources.map {|r| r.attributes.merge('unit'=>'hourly') },
        })
      end

      it do
        Job.create_or_update_with_resources!(params)
        expect(job.uri).to eql(params['uri'])
        expect(JobsInputResource.all.size).to eql(2)
        expect(JobsOutputResource.all.size).to eql(2)
        expect(Resource.all.size).to eql(4)
      end
    end

    context 'destroy resources' do
      let(:job) do
        FactoryGirl.create(:job_with_resources)
      end

      let(:params) do
        job.attributes
      end

      it do
        Job.create_or_update_with_resources!(params)
        expect(job.uri).to eql(params['uri'])
        expect(JobsInputResource.all.size).to eql(0)
        expect(JobsOutputResource.all.size).to eql(0)
        expect(Resource.all.size).to eql(0)
      end
    end
  end

  describe '#destroy_with_resources!' do
    let(:job) do
      FactoryGirl.create(:job_with_resources)
    end

    it do
      resource_ids = job.input_resources.map(&:id) + job.output_resources.map(&:id)
      job.destroy_with_resources!
      expect(Resource.where(id: resource_ids).size).to eql(0)
    end
  end
end
