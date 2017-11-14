# Agent (or Producer) sends a Message as an event
class Message < ApplicationRecord
  belongs_to :resource, primary_key: 'uri', foreign_key: 'resource_uri'

  validates :resource_uri, presence: true
  validates :resource_unit, presence: true, inclusion: { in: %w(singular daily hourly) }
  validates :resource_time, presence: true, numericality: { only_integer: true }
  validates :resource_timezone, presence: true, format: { with: /\A[+-]\d\d:\d\d\z/ }
  validates :payload, json: true

  def self.create_messages(params_list)
    ActiveRecord::Base.transaction do
      before = self.all.size
      params_list.each do |params|
        record = self.build_with_job_message(params)
        record.save! if record
      end
      {num_inserts: self.all.size - before}
    end
  end

  def self.build_with_job_message(params)
    return nil if params[:uuid] and Message.find_by(uuid: params[:uuid])

    resource_uri = params[:resource_uri] || raise('resource_uri is required')
    resource_unit = params[:resource_unit] || raise('resource_unit is required')
    resource_timezone = params[:resource_timezone] || raise('resource_timezone is required')

    resource_ids = Resource.where(
      uri: resource_uri,
      unit: resource_unit,
      timezone: resource_timezone
    ).pluck(:id)
    job_ids = JobsInputResource.where(
      resource_id: resource_ids
    ).pluck(:job_id)

    job_ids.each do |job_id|
      job = Job.find_by(id: job_id)
      params_with_job = params.merge(job_id: job_id)
      if job.logical_op&.downcase == 'and'.freeze
        JobMessage.create_if_andset(params_with_job)
      else
        JobMessage.create_if_orset(params_with_job)
      end
    end
    new(params)
  end
end
