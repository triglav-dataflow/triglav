class Message < ApplicationRecord
  belongs_to :resource, primary_key: 'uri', foreign_key: 'resource_uri'

  validates :resource_uri, presence: true
  validates :resource_unit, presence: true, inclusion: { in: %w(singular daily hourly) }
  validates :resource_time, presence: true, numericality: { only_integer: true }
  validates :resource_timezone, presence: true, format: { with: /\A[+-]\d\d:\d\d\z/ }
  validates :payload, json: true

  def self.create_messages(params_list)
    ActiveRecord::Base.transaction do
      objs = []
      params_list.each do |params|
        objs << self.build(params)
      end
      self.import(objs)
    end
  end

  def self.build(params)
    resource_uri = params[:resource_uri]
    resource_unit = params[:resource_unit]
    resource_timezone = params[:resource_timezone]

    resource_ids = Resource.where(
      uri: resource_uri,
      unit: resource_unit,
      timezone: resource_timezone
    ).pluck(:id)
    job_ids = JobsInputResource.where(
      resource_id: resource_ids
    ).pluck(:job_id)

    job_ids.each do |job_id|
      job_condition = Job.find_by(id: job_id).pluck(:condition)
      params_with_job = params.merge(job_id: job_id, job_condition: job_condition)
      if job_condition&.downcase == 'and'.freeze
        JobMessage.create_if_and_allset(params_with_job)
      else
        JobMessage.create_if_or_allset(params_with_job)
      end
    end
    new(params)
  end
end
