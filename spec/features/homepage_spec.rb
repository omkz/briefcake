require "rails_helper"

feature "Homepage" do
  scenario "Gets the homepage" do
    visit "/"

    expect(page).to have_text("Ready for that extra daily email?")
  end
end
