class CreatePerson < ActiveRecord::Migration
	def self.up
		create_table :persons do |t|
			t.string :name
		end

		Person.create(:name => "Bob Lee")
	end
	
	def self.down
		drop_table :persons
	end
end
