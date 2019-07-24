class SaveSentEmail
  def self.delivered_email(message)
    Email.new(message).save!
  end

  class Email
    attr_reader :sent_email
    attr_reader :message

    def initialize(message)
      @message = message
      @sent_email = SentEmail.new(
        sender: sender,
        receiver: receiver,
        user: user,
        subject: subject,
        body: filter_sensitive_data(body)
      )
    end

    def save!
      @sent_email.save!
    end

    def receiver
      @message.to.first
    end

    def sender
      @message.from.join(", ")
    end

    def subject
      @message.subject
    end

    def user
      User.find_by_email(receiver)
    end

    def filter_sensitive_data(text)
      text
    end

    def body
      if @message.html_part.present?
        @message.html_part.body.raw_source
      else
        @message.body.raw_source
      end
    end
  end
end

ActionMailer::Base.register_observer(SaveSentEmail)
