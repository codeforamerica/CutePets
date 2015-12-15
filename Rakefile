require 'rake/testtask'
require './lib/cute_pets'

Rake::TestTask.new do |t|
  t.pattern = 'spec/*_spec.rb'
end

desc 'Tweet random pet.'
task :post_pet_twitter do
  CutePets.post_pet(:twitter)
end

desc 'Post random pet.'
task :post_pet_facebook do
  CutePets.post_pet(:facebook)
end

task default: 'test'