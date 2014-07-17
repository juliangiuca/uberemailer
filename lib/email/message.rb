module Email
  class Message
    attr_reader :to, :from, :subject, :body

    def initialize(email)
      @to       = email.fetch("to")
      @from     = email.fetch("from")
      @body     = email.fetch("subject", " ")
      @subject  = email.fetch("body", " ")
    end
  end
end
