require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe '.create' do
    it do
      api_key = ApiKey.create!(user_id: 1)
      expect(api_key.access_token).to be_present
      expect(api_key.user_id).to be_present
      expect(api_key.expires_at).to be_present
      expect(api_key.last_accessed_at).to be_present
    end
  end

  describe '.find_by' do
    before { @api_key = ApiKey.create(user_id: 1) }

    it do
      api_key = ApiKey.find_by(access_token: @api_key.access_token)
      expect(api_key.access_token).to be_present
      expect(api_key.user_id).to be_present
      expect(api_key.expires_at).to be_present
      expect(api_key.last_accessed_at).to be_present
    end
  end

  describe '.expired?' do
    before { @api_key = ApiKey.create!(user_id: 1) }

    it do
      @api_key.tap {|a| a.expires_at = Time.current - 1 }.save!
      expect(ApiKey.expired?(access_token: @api_key.access_token)).to be_truthy
    end
  end

  describe 'extend_expiration' do
    before { @api_key = ApiKey.create(user_id: 1) }

    it do
      @api_key.tap {|a| a.expires_at = Time.current - 1 }.save
      expires_at = @api_key.expires_at
      @api_key.extend_expiration
      expect(@api_key.expires_at > expires_at).to be_truthy
    end
  end

  describe '#destroy' do
    before { @api_key = ApiKey.create(user_id: 1) }

    it do
      @api_key.destroy
      expect(ApiKey.find_by(access_token: @api_key.access_token)).to be_nil
    end
  end

  describe '.destroy_for_user' do
    before { @api_key = ApiKey.create(user_id: 1) }

    it do
      ApiKey.destroy_for_user(1)
      expect(ApiKey.find_by(user_id: 1)).to be_nil
    end
  end
end
