require "rspec"
require_relative "../../lib/email/message"
require_relative "../../lib/email/mandrill"

RSpec.describe Email::Mandrill, :type => :model do
  let(:email) { {
    "to"      => "julian.giuca@gmail.com",
    "from"    => "julian.giuca+1@gmail.com",
    "subject" => "subject",
    "body"    => "body"
    } }

  let(:message) { Email::Message.new(email) }
  subject(:mandrill) { Email::Mandrill.new(message) }

  describe "deliver" do
    it "should post a request" do
      expect( mandrill ).to receive(:post_request)
      mandrill.deliver
    end

    it "should return false on error" do
      allow( mandrill ).to receive(:post_request).and_raise(StandardError)
      expect( mandrill.deliver ).to be(false)
    end
  end

  describe "successful?" do
    it "should return false if there is no response" do
      expect( mandrill.successful? ).to be(false)
    end

    it "should return true if there is no reject reason" do
      allow( mandrill ).to receive(:response).and_return(double(body: {"reject_reason" => ""}.to_json))
      expect( mandrill.successful? ).to be(true)
    end

    it "should handle when the response has an error" do
      allow( mandrill ).to receive(:response).and_return(double(body: {"reject_reason" => "bad input"}.to_json))
      expect( mandrill.successful? ).to be(false)
    end

    it "should handle when the response body is html (or not json)" do
      allow( mandrill ).to receive(:response).and_return(double(body: "Not found error"))
      expect( mandrill.successful? ).to be(false)
    end
  end

end
