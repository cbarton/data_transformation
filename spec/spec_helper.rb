require 'rubygems'
require 'bundler'
require 'logger'
require 'rspec'
require 'active_record'

$LOAD_PATH.unshift(File.dirname(__FILE__) + "/../lib/")
require 'data_transformation'

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
#ActiveRecord::Base.configurations = YAML.load_file(File.dirname(__FILE__) + '/database.yml')

RSpec.configure do |config|
	config.mock_with :rspec
end
