require 'rubygems'
require 'bundler'
require 'logger'
require 'rails/all'
require 'rspec'

require 'data_transformation'
require 'generators/data_transformation/data_transformation_generator'

Dir[File.expand_path(File.dirname(__FILE__) + '/db')+"/*/*.rb"].each { |f| require f} 
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.configurations = YAML::load_file(File.dirname(__FILE__) + '/database.yml')
ActiveRecord::Base.establish_connection(ENV['DB'] || 'sqlite3')

RSpec.configure do |config|
	config.mock_with :rspec
end
