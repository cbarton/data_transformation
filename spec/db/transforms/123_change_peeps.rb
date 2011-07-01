class ChangePeeps < DataTransformation::Transformation
	def self.up
		p = Person.find_by_name("Bob Lee")
		p.update_attribute(:name, "George Lee")
	end
end
