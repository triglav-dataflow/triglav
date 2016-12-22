class User < ApplicationRecord
  serialize :groups, JSON

  ADMIN_ROLE = 'triglav_admin'
  def admin?
    !!self.groups.try(:include?, ADMIN_ROLE)
  end

  attr_accessor :password
  after_destroy :invalidate_api_keys

  # authenticator is reserved for future extension such as LDAP authentication
  validates :authenticator, :presence => true,
    :inclusion => ['local']

  validates :password, :presence => true, on: :create,
    if: ->(u) { u.authenticator == 'local' }

  validates_length_of :password,
    :in => (Settings.authentication.min_password_length .. 127),
    if: ->(u) { u.password.present? }

  before_save :encrypt_password
  after_save :clear_password

  def self.find_by_access_token(access_token)
    return nil unless api_key = ApiKey.find_by(access_token: access_token)
    unless api_key.expired?
      api_key.extend_expiration
      self.find_by(id: api_key.user_id)
    else
      nil
    end
  end

  def self.authenticate(sign_in_params)
    username, password = sign_in_params[:username], sign_in_params[:password]
    user = self.find_by(name: username, authenticator: 'local')
    return nil unless user
    if user.match_password?(password)
      return user
    else
      return false
    end
  end

  def match_password?(password="")
    encrypted_password == BCrypt::Engine.hash_secret(password, salt)
  end

  private

  def clear_password
    self.password = nil
    true
  end

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
    true
  end

  def invalidate_api_keys
    ApiKey.destroy_for_user(self.id)
    true
  end
end
