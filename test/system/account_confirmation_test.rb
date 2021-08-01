require "application_system_test_case"

class AccountConfirmationTest < ApplicationSystemTestCase
  setup do
    ActionMailer::Base.deliveries.clear
  end

  test "requires you to confirm via email" do
    # Sign up
    visit "/signup"

    visit "/signup"

    fill_in "Email", with: "jankees@example.com"
    fill_in "Password", with: "1234567890"

    click_on "Create an account"

    # Try to sign in without confirming
    visit "/login"
    fill_in "Email", with: "jankees@example.com"
    fill_in "Password", with: "1234567890"
    click_on "Log in"

    assert_content(page, "You have to confirm your email address before continuing.")

    # Confirm and sign in
    visit confirm_link_in_email

    assert_content(page, "You are now confirmed!")
    assert_content(page, "We are now able to send email.")

    click_on "Log in"

    fill_in "Email", with: "jankees@example.com"
    fill_in "Password", with: "1234567890"

    click_on "Log in"

    assert_content(page, "Signed in successfully.")
  end

  def confirm_link_in_email
    assert_equal(1, ActionMailer::Base.deliveries.count )
    email = ActionMailer::Base.deliveries.first
    email_body = email.parts.first.to_s
    regexp = /\/confirmation\?confirmation_token=.+?\s+/i
    regexp.match(email_body)[0].to_s
  end
end
