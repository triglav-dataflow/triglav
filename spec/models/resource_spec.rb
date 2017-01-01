require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe "#set_default" do
    context 'with daily' do
      let(:resource) do
        FactoryGirl.create(:resource, unit: 'daily')
      end

      it do
        expect(resource.span_in_days).to eq(32)
        expect(resource.timezone).to eq(Settings.resource.default_timezone)
      end
    end

    context 'with hourly' do
      let(:resource) do
        FactoryGirl.create(:resource, unit: 'hourly')
      end

      it do
        expect(resource.span_in_days).to eq(32)
        expect(resource.timezone).to eq(Settings.resource.default_timezone)
      end
    end
  end

  describe 'destroy with job relation' do
    let(:job) do
      FactoryGirl.create(:job_with_resources)
    end

    before { job }

    it do
      input_count_before_destroy = JobsInputResource.all.count
      job.input_resources.first.destroy
      expect(JobsInputResource.all.count).to eq(input_count_before_destroy - 1)

      output_count_before_destroy = JobsOutputResource.all.count
      job.output_resources.first.destroy
      expect(JobsOutputResource.all.count).to eq(output_count_before_destroy - 1)
    end
  end
end
