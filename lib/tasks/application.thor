ENV['RAILS_ENV'] ||= 'development'
require File.expand_path('../../../config/environment', __FILE__)

Application = Class.new(Cli::Application)
