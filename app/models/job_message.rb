class JobMessage < ApplicationRecord
  belongs_to :job
  validates :job_id, presence: true
  validates :time, presence: true, numericality: { only_integer: true }
  validates :timezone, presence: true, format: { with: /\A[+-]\d\d:\d\d\z/ }

  # 1) Fire if all resources in a job for a resource_time is set
  # 2) Back to 1 (that is, next comming event immediately fires a next OR message)
  def self.create_if_orset(params)
    job_id = params[:job_id] || raise('job_id is required')
    job_logical_op = params[:job_logical_op] || raise('job_logical_op is required')
    resource_uri = params[:resource_uri] || raise('resource_uri is required')
    resource_unit = params[:resource_unit] || raise('resource_unit is required')
    resource_time = params[:resource_time] || raise('resource_time is required')
    resource_timezone = params[:resource_timezone] || raise('resource_timezone is required')

    JobInternalMessage.create_with(
      job_logical_op: job_logical_op,
      resource_unit: resource_unit,
      resource_timezone: resource_timezone
    ).find_or_create_by(
      job_id: job_id,
      resource_time: resource_time,
      resource_uri: resource_uri,
    )
    input_resources_size = JobsInputResource.where(
      job_id: job_id
    ).size
    time_resources_size = JobInternalMessage.where(
      job_id: job_id,
      resource_time: resource_time
    ).size

    if time_resources_size == input_resources_size
      JobMessage.create(
        job_id: job_id,
        job_logical_op: job_logical_op,
        time: resource_time,
        timezone: resource_timezone
      )
    else
      nil
    end
  end

  # 1) Fire if all resources in a job for a resource_time is set
  # 2) Reset all events for the resource_time
  # 3) Back to 1
  def self.create_if_andset(params)
    obj = create_if_orset(params)
    return unless obj
    JobInternalMessage.where(
      job_id: params[:job_id],
      resource_time: params[:resource_time]
    ).destroy_all
    obj
  end
end
