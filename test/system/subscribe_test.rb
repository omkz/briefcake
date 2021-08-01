require "application_system_test_case"

class SubscribeTest < ApplicationSystemTestCase
  test "subscribes a user to the feed" do
    feed_url = "http://svn.com/feed.xml"
    url = "http://svn.com/"
    name = "Signal vs. Noise"

    form = create(:subscribe_form, slug: "signal-vs-noise", feed_url: feed_url, url: url, name: name)
    create(:site, subscribe_form_id: form.id, feed_url: feed_url, url: url, name: name)

    visit "/s/signal-vs-noise"

    fill_in "email", with: "jankees@hotmail.com"
    # expect { click_on "Subscribe" }.to change { User.last.feeds.count }.by(1)
    click_on "Subscribe"
    assert_equal(3, User.count)
    assert_equal(1, User.last.feeds.count)
    new_user = User.last

    assert_equal("jankees@hotmail.com", new_user.email)
    assert_equal(feed_url, new_user.feeds.first.feed_url)
    assert_equal(url, new_user.feeds.first.url)
    assert_equal(name, new_user.feeds.first.name)
    assert_equal(form, new_user.feeds.first.subscribe_form)
  end

  test "gives an error for existing users" do
    create(:subscribe_form, slug: "signal-vs-noise")
    user_email = "jankees@hotmail.com"
    create(:user, email: user_email)

    visit "/s/signal-vs-noise"

    fill_in "email", with: user_email
    click_on "Subscribe"

    assert_content(page, "You already have an account")
  end

  test "does not create an account for an invalid email address" do
    create(:subscribe_form, slug: "signal-vs-noise")

    visit "/s/signal-vs-noise"

    fill_in "email", with: "jankees@h"

    assert_no_difference -> { User.count } do
      click_on "Subscribe"
    end
    assert_content(page, "Invalid email address")
  end
end
