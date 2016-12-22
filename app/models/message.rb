class Message < ApplicationRecord
  belongs_to :resource, primary_key: 'uri', foreign_key: 'resource_uri'
end
