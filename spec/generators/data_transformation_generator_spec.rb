require 'spec_helper'
require 'generator_spec/test_case'
require 'generators/data_transformation/data_transformation_generator'

describe DataTransformationGenerator do
	include GeneratorSpec::TestCase
	destination File.expand_path('/tmp', __FILE__)
	tests DataTransformationGenerator
	arguments %w(test_transform)

	before do
		perpare_destination
		run_generator
	end	

	specify do
		destination_root.should have_structure {
			directory "db" do
				directory "transforms" do
					file "123_test_transform.rb"
					migration "test_transform" do
						contains "class TestTransform"
					end
				end
			end
		}
	end
end
