require "rails_helper"

feature "Dashboard" do
  it "sees the dashboard" do
    sign_in create(:user)

    visit root_path

    expect(page).to have_text("It's time to add your first feed, press the button.")
  end
end
