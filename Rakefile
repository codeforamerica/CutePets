require 'rake/testtask'
require './lib/cute_pets'

Rake::TestTask.new do |t|
  t.pattern = 'spec/*_spec.rb'
end

desc 'Tweet random pet.'
task :tweet_pet do
  CutePets.post_pet
end

task default: 'test'