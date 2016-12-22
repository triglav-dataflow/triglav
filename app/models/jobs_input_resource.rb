class JobsInputResource < ApplicationRecord
  belongs_to :job
  belongs_to :resource
end
