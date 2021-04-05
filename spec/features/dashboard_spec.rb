require "rails_helper"

feature "Dashboard" do
  it "adds hacker news as feed" do
    sign_in create(:user)
    visit root_path
    click_link "Add first feed"

    VCR.use_cassette("add-hacker-news") do
      fill_in "feed[url]", with: "https://news.ycombinator.com/"
      click_button "Find Feed"
      click_button "Add"
    end

    expect(page).to have_content "Feed was successfully created."
    expect(page).to have_content "Hacker News"
  end
end
