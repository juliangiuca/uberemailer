require "rspec"
require_relative "../lib/email"

RSpec.describe Email, :type => :model do
  describe "deliver" do
    let(:email) { {
      "to"      => "julian.giuca@gmail.com",
      "from"    => "julian.giuca+1@gmail.com",
      "subject" => "subject",
      "body"    => "body"
      } }

    let(:message) { double() }
    let(:mailgun) { double(deliver: true) }
    let(:mandrill) { double(deliver: true) }

    before do
      allow( Email::Message ).to receive(:new).and_return(message)
      allow( Email::Mailgun ).to receive(:new).and_return(mailgun)
      allow( Email::Mandrill ).to receive(:new).and_return(mandrill)
    end

    it "should create a new message" do
      expect( Email::Message ).to receive(:new).with(email)
      Email.deliver(email)
    end

    it "should create a new mailgun" do
      expect( Email::Mailgun ).to receive(:new).with(message)
      Email.deliver(email)
    end

    it "should create a new mandrill" do
      expect( Email::Mandrill ).to receive(:new).with(message)
      Email.deliver(email)
    end

    it "should call deliver on mailgun" do
      expect( mailgun ).to receive(:deliver).and_return(true)
      Email.deliver(email)
    end

    it "should call deliver on mandrill if mailgun fails" do
      allow( mailgun ).to receive(:deliver).and_return(false)
      expect( mandrill ).to receive(:deliver).and_return(true)
      Email.deliver(email)
    end

    it "should raise if mailgun and mandrill fail" do
      allow( mailgun ).to receive(:deliver).and_return(false)
      allow( mandrill ).to receive(:deliver).and_return(false)
      expect{ Email.deliver(email) }.to raise_error(Email::AllMailServersDown) 
    end
  end
end
