require 'rails/generators/active_record'
require 'rails/generators/migration'
require 'fileutils'

class DataTransformationGenerator < Rails::Generators::NamedBase
	include Rails::Generators::Migration

	def create_transform_file
		create_transforms_folder
		migration_template "transform.rb", "db/transforms/#{file_name}.rb"
	end	

	def self.next_migration_number(dirname)
		ActiveRecord::Generators::Base.next_migration_number(dirname)
	end

	def create_transforms_folder
		FileUtils.mkdir("db/transforms") unless Dir.exists?("db/transforms")
	end
end
