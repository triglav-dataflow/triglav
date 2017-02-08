require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message_params) {
    {
      resource_uri: 'hdfs://foo/bar',
      resource_unit: 'daily',
      resource_time: 1356361200,
      resource_timezone: '+09:00',
      payload: '{"path":"hdfs://foo/bar","last_modification_time":1356361200000}',
    }
  }

  describe '#validates' do
    it 'valid' do
      expect { Message.create!(message_params) }.not_to raise_error
    end

    it 'invalid' do
      expect { Message.create!(message_params.except(:resource_uri)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Message.create!(message_params.except(:resource_unit)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Message.create!(message_params.except(:resource_time)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Message.create!(message_params.except(:resource_timezone)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { Message.create!(message_params.merge(payload: 'foo')) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  # activerecord-import
  describe '#import' do
    it do
      result = Message.import([Message.new(message_params)])
      expect(result[:num_inserts]).to eq(1)
    end
  end

  describe 'build_with_job_message' do
    let(:job) do
      FactoryGirl.create(:job_with_single_resource)
    end

    let(:resource) do
      job.input_resources.first
    end

    let(:message_params) {
      {
        resource_uri: resource.uri,
        resource_unit: resource.unit,
        resource_timezone: resource.timezone,
        resource_time: 1356361200,
        payload: '{"path":"hdfs://foo/bar","last_modification_time":1356361200000}',
      }
    }

    it do
      subject = Message.build_with_job_message(message_params)
      expect(JobMessage.all.size).to be > 0
    end
  end

  describe 'create_messages' do
    let(:job) do
      FactoryGirl.create(:job_with_single_resource)
    end

    let(:resource) do
      job.input_resources.first
    end

    let(:message_params) {
      {
        resource_uri: resource.uri,
        resource_unit: resource.unit,
        resource_timezone: resource.timezone,
        resource_time: 1356361200,
        payload: '{"path":"hdfs://foo/bar","last_modification_time":1356361200000}',
      }
    }

    it do
      result = Message.create_messages([message_params])
      expect(result[:num_inserts]).to eq(1)
    end
  end
end
