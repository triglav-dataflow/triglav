require 'securerandom'

class ApiKey < ApplicationRecord
  belongs_to :user

  validates :user_id, :presence => true

  before_create :generate_access_token
  before_create :extend_expiration

  scope :expired, -> { where('expires_at < ?', Time.current) }

  def expired?
    self.expires_at < Time.current
  end

  def extend_expiration
    self.expires_at = ApiKey.expires_at
    self.last_accessed_at = Time.current
    self
  end

  def self.expired?(access_token: )
    api_key = self.find_by(access_token: access_token)
    api_key ? api_key.expired? : true
  end

  def self.destroy_for_user(user_id)
    ApiKey.where(user_id: user_id).destroy_all
  end

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
    access_token
  end

  def self.expires_at
    (Time.current + Settings.authentication.expire.days)
  end
end
