# frozen-string-literal: true

class Resource < ApplicationRecord
  has_many :messages, primary_key: 'uri', foreign_key: 'resource_uri'

  validates :unit, inclusion: { in: %w(daily hourly daily,hourly) } # monthly, streaming support?
  validates :timezone, presence: true, format: { with: /\A[+-]\d\d:\d\d\z/ }

  before_save :set_default

  def set_default
    self.timezone ||= Settings.resource.default_timezone
    self.span_in_days ||= Settings.resource.default_span_in_days
    true
  end

  def self.create_or_update!(params)
    if resource = self.find_by(id: params['id'])
      resource.update!(params)
      resource
    else
      self.create!(params)
    end
  end
end
