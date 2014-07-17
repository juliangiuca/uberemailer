require 'net/http'
require "dotenv"
require_relative "email/message"
require_relative "email/mandrill"
require_relative "email/mailgun"

# Secret env vars being loaded
Dotenv.load

module Email
  class AllMailServersDown < StandardError; end

  def self.deliver(email)
    message  = Message.new(email)
    mailgun  = Mailgun.new(message)
    mandrill = Mandrill.new(message)

    mailgun.deliver || mandrill.deliver || (raise AllMailServersDown, "No mail server completed the request")
  end


end
