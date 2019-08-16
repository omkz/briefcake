class ApplicationMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def confirm_email_instructions
    Devise::Mailer.confirmation_instructions(User.first, "faketoken", {})
  end
end
