require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  test "adds hacker news as feed" do
    sign_in create(:user)
    visit root_path
    click_link "Add first feed"

    VCR.use_cassette("add-hacker-news") do
      fill_in "feed[url]", with: "https://news.ycombinator.com/"
      click_button "Find Feed"
      click_button "Add"
    end

    assert_content(page, "Feed was successfully created.")
    assert_content(page, "Hacker News")
  end
end
