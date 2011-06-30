namespace :db do
	task :load_config => :rails_env do
		DataTransformation::Transformer.migration_paths = Rails.application.paths['db/transforms'].to_a
	end

	desc "Transform the database (options: VERSION=x, VERBOSE=false)."
	task :transform => :environment do
		module ActiveRecord
			class Migrator
				def self.schema_migrations_table_name
					Base.table_name_prefix + "schema_transforms" + Base.table_name_suffix
				end
			end
		end

		module ActiveRecord
			module ConnectionAdapters
				module SchemaStatements
					def initialize_schema_migrations_table
        	  sm_table = ActiveRecord::Migrator.schema_migrations_table_name

        		unless table_exists?(sm_table)
          		create_table(sm_table, :id => false) do |schema_migrations_table|
            		schema_migrations_table.column :version, :string, :null => false
          		end
          		add_index sm_table, :version, :unique => true,
            		:name => "#{Base.table_name_prefix}unique_schema_transforms#{Base.table_name_suffix}"

          		# Backwards-compatibility: if we find schema_info, assume we've
          		# migrated up to that point:
          		si_table = Base.table_name_prefix + 'schema_info' + Base.table_name_suffix

          		if table_exists?(si_table)
           			old_version = select_value("SELECT version FROM #{quote_table_name(si_table)}").to_i
           			assume_migrated_upto_version(old_version)
          			drop_table(si_table)
          		end
      			end
					end
				end
			end
		end

	
		DataTransformation::Transformation.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == "true" : true
		DataTransformation::Transformer.transform('db/transforms/', ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
		Rake::Task['db:schema:dump'].invoke	if ActiveRecord::Base.schema_format == :ruby
	end

	task :abort_if_pending_migrations => :environment do
		if defined? DataTransformation
			pending_transformations = DataTransformation::Transformer.new(:up, DataTransformation::Transformer.migrations_paths).pending_migrations

			if pending_transformations.any?
				puts "You have #{pending_transformations.size} pending transformations."
				pending_transformations.each do |m|
					puts '  %4d %s' % [m.version, m.name]
				end
				abort %{Run "rake db:transform" to update your database then try again.}
			end
		end
	end
end
