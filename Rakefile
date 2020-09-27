require 'sinatra/activerecord/rake'
require_relative './config/environment'
Dir.glob('lib/tasks/*.rake').each { |r| load r }
require 'pry'

task :console do
  Pry.start 
end
