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
end
