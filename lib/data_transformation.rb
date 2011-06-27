require "data_transformation/version"
require 'data_transformation/transformer'

module DataTransformation
	class Railtie < Rails::Railtie
		rake_tasks do
			load 'lib/tasks/data_transformations.rake'
		end
	end
end
