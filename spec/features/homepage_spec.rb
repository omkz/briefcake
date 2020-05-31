require "rails_helper"

feature "Homepage" do
  scenario "Gets the homepage" do
    visit "/"

    expect(page).to have_text("Ready to simplify your feed?")
  end
end
