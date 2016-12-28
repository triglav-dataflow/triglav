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

  # @param [Hash] params
  # @option params [String] :uri_prefix
  #
  # @todo: Using materialized view is better (In mysql, insert select with trigger)
  #
  # EXAMPLE:
  # uri       unit    span_in_days consumable notifiable
  # hdfs://a  hourly  10           true       false
  # hdfs://a  daily   32           true       false
  # hdfs://b  hourly  32           true       false
  # hdfs://b  hourly  32           true       true
  #
  # non_notifiable_uris =>
  # ['hdfs://a']
  #
  # aggregated_resources =>
  # uri       unit         span_in_days
  # hdfs://a  daily,hourly 32
  def self.aggregated_resources(params)
    raise ArgumentError, ':uri_prfix is required' unless params[:uri_prefix]

    non_notifiable_uris = Resource.
      where('uri LIKE ?', "#{params[:uri_prefix]}%").
      group('uri').
      having('BIT_OR(notifiable) = false').
      pluck('uri')

    aggregated_resources = Resource.
      select('uri, GROUP_CONCAT(DISTINCT(unit) order by unit) AS unit, timezone, MAX(span_in_days) AS span_in_days').
      where(uri: non_notifiable_uris).
      where(consumable: true).
      group('uri', 'timezone').
      order('uri')
  end
end
