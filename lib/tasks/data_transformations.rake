namespace :db do
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
end
