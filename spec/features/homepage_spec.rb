require "rails_helper"

feature "Homepage" do
  scenario "Gets the homepage" do
    visit "/"

    expect(page).to have_text("A daily email from your\nfavorite creators")
  end
end
