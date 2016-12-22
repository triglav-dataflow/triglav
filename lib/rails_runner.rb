# cf. http://qiita.com/sonots/items/2bf7f15adb40c012a643

APP_PATH = File.expand_path('../../config/application', __FILE__) unless defined?(APP_PATH)
require_relative '../config/boot'

options = { environment: (ENV['RAILS_ENV'] || ENV['RACK_ENV'] || "development").dup }
ENV["RAILS_ENV"] = options[:environment]

require APP_PATH
Rails.application.require_environment!
Rails.application.load_runner
