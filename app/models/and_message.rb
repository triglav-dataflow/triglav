class AndMessage < ApplicationRecord
  belongs_to :job
  validates :resource_time, presence: true, numericality: { only_integer: true }
  validates :resource_timezone, presence: true, format: { with: /\A[+-]\d\d:\d\d\z/ }

  # 1) Fire if all resources in a job for a resource_time is set
  # 2) Reset all events for the resource_time
  # 3) Back to 1
  def self.create_if_allset(params)
    job_id = params[:job_id]
    resource_uri = params[:resource_uri]
    resource_unit = params[:resource_unit]
    resource_timezone = params[:resource_timezone]

    AndInternalMessage.create_with(
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
    time_resources_size = AndInternalMessage.where(
      job_id: job_id,
      resource_time: resource_time
    ).size

    if time_resources_size == input_resources_size
      AndMessage.create(
        job_id: job_id,
        resource_time: resource_time,
        resource_timezone: resource_timezone
      )
      AndInternalMessage.where(
        job_id: job_id,
        resource_time: resource_time
      ).destroy_all
    end
  end
end
