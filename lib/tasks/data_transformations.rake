namespace :db do
	task :load_config => :rails_env do
		DataTransformation::Transformer.migration_paths = Rails.application.paths['db/transforms'].to_a
	end

	desc "Transform the database (options: VERSION=x, VERBOSE=false)."
	task :transform => :environment do
		module ActiveRecord
			class Migrator
				def self.schema_migrations_table
					Base.table_name_prefix + "schema_transforms" + Base.table_name_suffix
				end
			end
		end
	
		DataTransformation::Transformation.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == "true" : true
		DataTransformation::Transformer.transform('db/transforms/', ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
		
	end

	task :abort_if_pending_migrations => :environment do
		if defined? DataTransformation
		pending_transformations = DataTransformation::Transformer.new(:up, DataTransformation::Transformer.migration_paths).pending_migrations

		if pending_migrations.any?
			puts "You have #{pending_migrations.size} pending transformations."
			pending_migrations.each do |m|
				puts '  %4d %s' % [pending_migration.version, pending_migration.name]
      end
      abort %{Run "rake db:transform" to update your database then try again.}
		end
	end
end
