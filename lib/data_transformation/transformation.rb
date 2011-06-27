require 'active_record/migration'

module DataTransformation
	class Transformation < ActiveRecord::Migration
		def transform(direction)
			migrate(direction)
		end
	end
end
