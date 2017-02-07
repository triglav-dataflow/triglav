class OrMessage < ApplicationRecord
  belongs_to :job
  validates :time, presence: true, numericality: { only_integer: true }
  validates :timezone, presence: true, format: { with: /\A[+-]\d\d:\d\d\z/ }

  # 1) Fire if all resources in a job for a resource_time is set
  # 2) Back to 1 (that is, next coming event immediately fires a next "OR" event)
  def self.create_if_allset(params)
    job_id = params[:job_id]
    resource_uri = params[:resource_uri]
    resource_unit = params[:resource_unit]
    resource_timezone = params[:resource_timezone]

    OrInternalMessage.create_with(
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
    time_resources_size = OrInternalMessage.where(
      job_id: job_id,
      resource_time: resource_time
    ).size

    if time_resources_size == input_resources_size
      OrMessage.create(
        job_id: job_id,
        time: resource_time,
        timezone: resource_timezone
      )
    end
  end
end
