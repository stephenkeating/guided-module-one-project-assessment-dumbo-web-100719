require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "Start our app console"
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

task :run do
  GdsApp.main_menu
  # GdsApp.choose_character
  # # GdsApp.character_page
end
