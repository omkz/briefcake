require "rails_helper"

RSpec.describe BriefcakeMailer, type: :mailer do
  describe "transition_email" do
    let(:mail) { BriefcakeMailer.transition_email }

    it "renders the headers" do
      pending "make sure the email is going to the user #{__FILE__}"
      raise
      # expect(mail.subject).to eq("Transition email")
      # expect(mail.to).to eq(["to@example.org"])
      # expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      pending "make sure the email's body is what we expect #{__FILE__}"
      raise
      # expect(mail.body.encoded).to match("Hi")
    end
  end

end
