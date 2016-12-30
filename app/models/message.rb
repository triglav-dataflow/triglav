class Message < ApplicationRecord
  belongs_to :resource, primary_key: 'uri', foreign_key: 'resource_uri'

  validates :resource_uri, presence: true
  validates :resource_unit, presence: true, inclusion: { in: %w(daily hourly daily,hourly) }
  validates :resource_time, presence: true, numericality: { only_integer: true }
  validates :resource_timezone, presence: true, format: { with: /\A[+-]\d\d:\d\d\z/ }
  validates :payload, json: true
end
