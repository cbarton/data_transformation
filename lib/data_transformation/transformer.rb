require 'active_record/migration'

module DataTransformation
	class Transformer < ActiveRecord::Migrator
		class << self
			def transform(transforms_path, target_version=nil)
				migrate(transforms_path, target_version)
			end			
		end

		def migrations_path
			'db/transforms'
		end

		def schema_migrations_table_name
			ActiveRecord::Base.table_name_prefix + "schema_transforms" + ActiveRecord::Base.table_name_suffix
		end
	end	
end
