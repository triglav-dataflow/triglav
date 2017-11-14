class JobMessage < ApplicationRecord
  belongs_to :job
  validates :job_id, presence: true
  validates :time, presence: true, numericality: { only_integer: true }
  validates :timezone, presence: true, format: { with: /\A[+-]\d\d:\d\d\z/ }

  # OR conditions
  #
  # 1) Fire if all input resources of a job for a specific resource_time is set
  #
  # 1. Created
  #
  # |          | 2017-04-16 | 2017-04-17 |
  # |:---------|:-----------|:-----------|
  # |ResourceA |            | Created(*) |
  # |ResourceB |            |            |
  #
  # 2. Created => Fire
  #
  # |          | 2017-04-16 | 2017-04-17 |
  # |:---------|:-----------|:-----------|
  # |ResourceA |            | Created    |
  # |ResourceB |            | Created(*) |
  #
  # 3. Updated => Fire
  #
  # |          | 2017-04-16 | 2017-04-17 |
  # |:---------|:-----------|:-----------|
  # |ResourceA |            | Updated(*) |
  # |ResourceB |            | Created    |
  def self.create_if_orset(params)
    job_id = params[:job_id] || raise('job_id is required')
    resource_uri = params[:resource_uri] || raise('resource_uri is required')
    resource_unit = params[:resource_unit] || raise('resource_unit is required')
    resource_time = params[:resource_time] || raise('resource_time is required')
    resource_timezone = params[:resource_timezone] || raise('resource_timezone is required')

    resource_ids = JobsInputResource.where(job_id: job_id).pluck(:resource_id)
    resource = Resource.where(id: resource_ids).where(uri: resource_uri).first
    return nil unless resource
    if resource.span_in_days
      return nil unless resource.in_span?(resource_time)
    end

    JobInternalMessage.create_with(
      resource_unit: resource_unit,
      resource_timezone: resource_timezone
    ).find_or_create_by(
      job_id: job_id,
      resource_time: resource_time,
      resource_uri: resource_uri,
    )

    input_resources_size = JobsInputResource.where(job_id: job_id).size
    time_resources_size = JobInternalMessage.where(job_id: job_id, resource_time: resource_time).size

    if time_resources_size == input_resources_size
      # Fire
      JobMessage.create(job_id: job_id, time: resource_time, timezone: resource_timezone)
    else
      nil
    end
  end

  # AND conditions
  #
  # 1) Fire if all input resources of a job for a specific resource_time is set
  # 2) Reset all events for the resource_time after fired
  #
  # 1. Created
  #
  # |          | 2017-04-16 | 2017-04-17 |
  # |:---------|:-----------|:-----------|
  # |ResourceA |            | Created(*) |
  # |ResourceB |            |            |
  #
  # 2. Created => Fire
  #
  # |          | 2017-04-16 | 2017-04-17 |
  # |:---------|:-----------|:-----------|
  # |ResourceA |            | Created    |
  # |ResourceB |            | Created(*) |
  #
  # Then, once delete
  #
  # |          | 2017-04-16 | 2017-04-17 |
  # |:---------|:-----------|:-----------|
  # |ResourceA |            |            |
  # |ResourceB |            |            |
  #
  # 3. Updated
  #
  # |          | 2017-04-16 | 2017-04-17 |
  # |:---------|:-----------|:-----------|
  # |ResourceA |            | Updated(*) |
  # |ResourceB |            |            |
  #
  # 4. Updated => Fire
  #
  # |          | 2017-04-16 | 2017-04-17 |
  # |:---------|:-----------|:-----------|
  # |ResourceA |            | Updated    |
  # |ResourceB |            | Updated(*) |
  def self.create_if_andset(params)
    obj = create_if_orset(params)
    return unless obj
    JobInternalMessage.where(job_id: params[:job_id], resource_time: params[:resource_time]).destroy_all
    obj
  end
end
