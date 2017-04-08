require 'rails_helper'

RSpec.describe JobMessage, type: :model do
  let(:job_message_params) {
    {
      job_id: 1,
      time: 1356361200,
      timezone: '+09:00',
    }
  }

  describe '#validates' do
    it 'valid' do
      expect { JobMessage.create!(job_message_params) }.not_to raise_error
    end

    it 'invalid' do
      expect { JobMessage.create!(job_message_params.except(:job_id)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { JobMessage.create!(job_message_params.except(:time)) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { JobMessage.create!(job_message_params.except(:timezone)) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  let(:message_params_with_job) {
    {
      job_id: 1,
      resource_uri: 'hdfs://foo/bar',
      resource_unit: 'daily',
      resource_time: 1356361200,
      resource_timezone: '+09:00',
    }
  }

  let(:job_with_single_resource) do
    FactoryGirl.create(:job_with_single_resource)
  end

  let(:job_with_or_resources) do
    FactoryGirl.create(:job_with_or_resources)
  end

  let(:job_with_and_resources) do
    FactoryGirl.create(:job_with_and_resources)
  end

  let(:now) { Time.parse('2012-12-28 00:00:00 +0900') }

  before do
    Timecop.freeze(now)
  end

  after do
    Timecop.return
  end

  describe 'create_if_orset' do
    context 'with single input resource' do
      it do
        job = job_with_single_resource
        resource = job.input_resources.first
        params = {
          job_id: job.id,
          resource_uri: resource.uri,
          resource_unit: resource.unit,
          resource_time: Time.now.to_i,
          resource_timezone: resource.timezone
        }
        subject = JobMessage.create_if_orset(params)
        expect(subject).to be_present
        expect(subject.job_id).to eq(params[:job_id])
        expect(subject.time).to eq(params[:resource_time])
        expect(subject.timezone).to eq(params[:resource_timezone])
      end
    end

    context 'with multiple input resources' do
      it do
        job = job_with_or_resources
        resources = job.input_resources

        (0...resources.size-1).each do |i|
          resource = resources[i]
          params = {
            job_id: job.id,
            resource_uri: resource.uri,
            resource_unit: resource.unit,
            resource_time: Time.now.to_i,
            resource_timezone: resource.timezone
          }
          subject = JobMessage.create_if_orset(params)
          expect(subject).to be_nil
        end

        resource = resources.last
        params = {
          job_id: job.id,
          resource_uri: resource.uri,
          resource_unit: resource.unit,
          resource_time: Time.now.to_i,
          resource_timezone: resource.timezone
        }
        # all set
        subject = JobMessage.create_if_orset(params)
        expect(subject).to be_present
        expect(subject.job_id).to eq(params[:job_id])
        expect(subject.time).to eq(params[:resource_time])
        expect(subject.timezone).to eq(params[:resource_timezone])

        # a next comming event fires next OR event immediatelly
        subject = JobMessage.create_if_orset(params)
        expect(subject).to be_present
      end
    end

    context 'with resource_time in span_in_days' do
      it do
        job = job_with_single_resource
        resource = job.input_resources.first
        resource.tap {|r| r.span_in_days = 1 }.save!
        params = {
          job_id: job.id,
          resource_uri: resource.uri,
          resource_unit: resource.unit,
          resource_time: Time.now.to_i,
          resource_timezone: resource.timezone
        }
        subject = JobMessage.create_if_orset(params)
        expect(subject).to be_present
        expect(subject.job_id).to eq(params[:job_id])
        expect(subject.time).to eq(params[:resource_time])
        expect(subject.timezone).to eq(params[:resource_timezone])
      end
    end

    context 'with resource_time not in span_in_days' do
      it do
        job = job_with_single_resource
        resource = job.input_resources.first
        resource.tap {|r| r.span_in_days = 1 }.save!
        params = {
          job_id: job.id,
          resource_uri: resource.uri,
          resource_unit: resource.unit,
          resource_time: Time.now.to_i - 24*3600 -1,
          resource_timezone: resource.timezone
        }
        subject = JobMessage.create_if_orset(params)
        expect(subject).to be_nil
      end
    end
  end

  describe 'create_if_andset' do
    context 'with single input resource' do
      it do
        job = job_with_single_resource
        resource = job.input_resources.first
        params = {
          job_id: job.id,
          resource_uri: resource.uri,
          resource_unit: resource.unit,
          resource_time: Time.now.to_i,
          resource_timezone: resource.timezone
        }
        subject = JobMessage.create_if_andset(params)
        expect(subject).to be_present
        expect(subject.job_id).to eq(params[:job_id])
        expect(subject.time).to eq(params[:resource_time])
        expect(subject.timezone).to eq(params[:resource_timezone])
      end
    end

    context 'with multiple input resources' do
      it do
        job = job_with_and_resources
        resources = job.input_resources

        (0...resources.size-1).each do |i|
          resource = resources[i]
          params = {
            job_id: job.id,
            resource_uri: resource.uri,
            resource_unit: resource.unit,
            resource_time: Time.now.to_i,
            resource_timezone: resource.timezone
          }
          subject = JobMessage.create_if_andset(params)
          expect(subject).to be_nil
        end

        resource = resources.last
        params = {
          job_id: job.id,
          resource_uri: resource.uri,
          resource_unit: resource.unit,
          resource_time: Time.now.to_i,
          resource_timezone: resource.timezone
        }
        # all set
        subject = JobMessage.create_if_andset(params)
        expect(subject).to be_present
        expect(subject.job_id).to eq(params[:job_id])
        expect(subject.time).to eq(params[:resource_time])
        expect(subject.timezone).to eq(params[:resource_timezone])

        # a next comming event does not fire AND event until all events are set
        subject = JobMessage.create_if_andset(params)
        expect(subject).to be_nil
      end
    end
  end
end
