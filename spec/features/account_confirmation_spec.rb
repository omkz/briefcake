require "rails_helper"

feature "Signing up" do
  it "only sends emails to confirmed users" do
    # Sign up
    visit "/signup"

    fill_in "Name", with: "Jankees"
    fill_in "Email", with: "jankees@example.com"
    fill_in "Password", with: "1234567890"

    click_on "Create an account"
    expect(page).to have_content "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."

    # Try to sign in without confirming
    visit "/login"
    fill_in "Email", with: "jankees@example.com"
    fill_in "Password", with: "1234567890"
    click_on "Log in"

    expect(page).to have_content "You have to confirm your email address before continuing."

    # Confirm and sign in
    visit confirm_link_in_email

    expect(page).to have_content "Your email address has been successfully confirmed."

    fill_in "Email", with: "jankees@example.com"
    fill_in "Password", with: "1234567890"

    click_on "Log in"

    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "You can also import an .opml file"
  end

  def confirm_link_in_email
    expect(ActionMailer::Base).to have(1).delivery
    email = ActionMailer::Base.deliveries.first
    email_body = email.parts.first.to_s
    regexp = /\/confirmation\?confirmation_token=.+?\s+/i
    regexp.match(email_body)[0].to_s
  end
end
