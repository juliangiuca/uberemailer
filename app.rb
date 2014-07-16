require 'sinatra'
require 'byebug'

RACK_ENV ||= ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT ||= File.expand_path(File.dirname(__FILE__))

get '/' do
  haml :index
end

post '/email' do
  byebug
  i=0
  i+=1
end
