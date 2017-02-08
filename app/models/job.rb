class Job < ApplicationRecord
  validates :condition, inclusion: { in: %w(and or) }
  has_many :jobs_input_resources, dependent: :destroy
  has_many :input_resources, through: :jobs_input_resources, source: 'resource'
  has_many :jobs_output_resources, dependent: :destroy
  has_many :output_resources, through: :jobs_output_resources, source: 'resource'

  # This method does not support `id_or_uri`, but requires `id` to update `uri` parameter
  # This method also requires ids for input and output resources to update them
  # `output_resources` would be empty for some jobs which does not transfer data such as argus
  def self.create_or_update_with_resources!(params)
    if job = self.find_by(id: params['id'])
      job.update_with_resources!(params)
      job
    else
      self.create_with_resources!(params)
    end
  end

  def destroy_with_resources!
    Job.transaction do
      input_resources.each {|r| r.destroy! }
      output_resources.each {|r| r.destroy! }
      self.destroy!
    end
  end

  # private

  def self.create_with_resources!(params)
    Job.transaction do
      job = Job.create!(params.except('input_resources', 'output_resources'))
      Job.set_input_output_resources!(job, params)
      job
    end
  end

  def update_with_resources!(params)
    Job.transaction do
      Job.set_input_output_resources!(self, params)
      self.update!(params.except('input_resources', 'output_resources'))
    end
  end

  def self.set_input_output_resources!(job, params)
    params = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h : params
    (params['input_resources'] || []).map {|r| r['consumable'] = true }
    (params['output_resources'] || []).map {|r| r['consumable'] = false }
    Job.set_resources!(job, JobsInputResource, params['input_resources'])
    Job.set_resources!(job, JobsOutputResource, params['output_resources'])
  end

  def self.set_resources!(job, relation_class, resource_params_list)
    resource_params_list ||= []
    current_ids = relation_class.where(job_id: job.id).pluck(:resource_id)

    # destroy
    request_ids = resource_params_list.map {|p| p['id'] }.compact
    destroy_ids = current_ids - request_ids
    if destroy_ids.present?
      relation_class.where(job_id: job.id, resource_id: destroy_ids).destroy_all
      Resource.where(id: destroy_ids).destroy_all
    end

    # create or update
    (resource_params_list || []).each do |resource_params|
      resource = Resource.create_or_update!(resource_params)
      relation_class.find_or_create_by!(job_id: job.id, resource_id: resource.id)
    end
  end
end
