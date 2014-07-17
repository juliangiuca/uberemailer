require "net/http"

module Email
  class Mailgun
    attr_reader :message, :uri, :response

    def initialize(new_message)
      @message = new_message
      @uri = URI.parse("https://api.mailgun.net/v2/sandbox667d5811e9d54bb58a60c0bdc1f17fed.mailgun.org/messages")
    end

    def deliver
      begin
        post_request && successful?
      rescue => e
        puts e
        false
      end
    end

    def successful?
      !!(response && response.code == "200")
    end

    private
    def payload
      {
        from: message.from,
        to: message.to,
        subject: message.subject,
        text: message.body
      }
    end

    def post_request
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.open_timeout = 1000

        req = Net::HTTP::Post.new(uri.path)
        req.basic_auth("api", ENV['MAILGUN_KEY'])
        req.set_form_data(payload)

        @response = http.request(req)
    end

  end
end
