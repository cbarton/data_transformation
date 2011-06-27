namespace :db do
	desc "Transform the database (options: VERSION=x, VERBOSE=false)."
	task :transform => :environment do
		DataTransformation::Transformation.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == "true" : true
		DataTransformation::Transformer.transform('db/transforms/', ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
	end
end
