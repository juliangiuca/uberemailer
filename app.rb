require 'sinatra'
require "json"
require "haml"
require_relative "./lib/email"

RACK_ENV ||= ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'
RACK_ROOT ||= File.expand_path(File.dirname(__FILE__))

class UberEmailer < Sinatra::Application
  set(:accepted_verbs) { |*verbs| condition { verbs.any?{|v| v == request.request_method }  } }

  before "*", accepted_verbs: ["POST", "PATCH", "PUT"] do
    @request_payload ||= JSON.load(request.body)
  end

  error Email::AllMailServersDown do
    status 500
    "Could not send"
  end

  get '/' do
    haml :index
  end

  post '/api/v1/send' do

    begin
      status 200
      content_type :json
      Email.deliver(@request_payload)

      {}.to_json
    rescue => e
      logger.error("Email failed. Message: #{e.message}. Params: #{@request_payload}")
    end
  end

end
