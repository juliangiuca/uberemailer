require "rspec"
require_relative "../../lib/email/message"
require_relative "../../lib/email/mailgun"

RSpec.describe Email::Mailgun, :type => :model do
  let(:email) { {
    "to"      => "julian.giuca@gmail.com",
    "from"    => "julian.giuca+1@gmail.com",
    "subject" => "subject",
    "body"    => "body"
    } }

  let(:message) { Email::Message.new(email) }
  subject(:mailgun) { Email::Mailgun.new(message) }

  describe "deliver" do
    it "should post a request" do
      expect( mailgun ).to receive(:post_request)
      mailgun.deliver
    end

    it "should return false on error" do
      allow( mailgun ).to receive(:post_request).and_raise(StandardError)
      expect( mailgun.deliver ).to be(false)
    end
  end

  describe "successful?" do
    it "should return false if there is no response" do
      expect( mailgun.successful? ).to be(false)
    end

    it "should return true if there is no reject reason" do
      allow( mailgun ).to receive(:response).and_return(double(code: "200"))
      expect( mailgun.successful? ).to be(true)
    end

    it "should handle when the response has an error" do
      allow( mailgun ).to receive(:response).and_return(double(code: "400"))
      expect( mailgun.successful? ).to be(false)
    end

  end

end
