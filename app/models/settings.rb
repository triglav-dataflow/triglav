# NOTE: This file would be `require`ed by unicorn.rb before loading rails
require 'settingslogic'

class Settings < Settingslogic
  source File.expand_path("../../config/settings.yml", __dir__)
  namespace defined?(Rails) ? Rails.env : ENV['RACK_ENV'] # unicorn -E RACK_ENV
end
