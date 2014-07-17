require "net/http"
require 'json'

module Email
  class Mandrill
    attr_reader :message, :uri, :response

    def initialize(new_message)
      @message = new_message
      @uri = URI("https://mandrillapp.com/api/1.0/messages/send.json")
    end

    def deliver
      begin
        post_request && successful?
      rescue => e
        puts e
        #Swallow all the things. This means timeouts, conn errs.
        false
      end
    end

    def successful?
      return false unless response

      begin
        parsed_response = JSON.parse(response.body)
        parsed_response["reject_reason"].empty?
      rescue JSON::ParserError
        false
      end

    end


    private
    def payload
      {
        key: ENV['MANDRILL_KEY'],
        message: {
          text:     message.body,
          subject:  message.subject,
          to: [{email: message.to}],
          from_email: message.from
        }
      }
    end

    def post_request
      http = Net::HTTP.new(uri.host)
      req = Net::HTTP::Post.new(uri.path)
      req.body = payload.to_json
      http.open_timeout = 1000

      @response = http.request(req)
    end

  end
end



private
