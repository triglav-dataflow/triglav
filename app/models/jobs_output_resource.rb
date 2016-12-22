class JobsOutputResource < ApplicationRecord
  belongs_to :job
  belongs_to :resource
end
