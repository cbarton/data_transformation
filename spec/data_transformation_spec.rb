require 'spec_helper'

class Person < ActiveRecord::Base
	set_table_name :persons
end

describe DataTransformation do
	before(:all) do
		CreatePerson.up
	end
	after(:all) do
		CreatePerson.down
	end

	it "should transform the data" do
		Person.first.name.should == "Bob Lee"
		ChangePeeps.up
		Person.first.name.should == "George Lee"
	end
end
