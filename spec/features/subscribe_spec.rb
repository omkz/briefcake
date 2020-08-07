require "rails_helper"

feature "Signing up" do
  pending "gives a 404 for an invalid slug" do
    expect { visit "/s/something-else" }.to raise_error ActiveRecord::RecordNotFound
  end

  it "subscribes a user to the feed" do
    feed_url = "http://svn.com/feed.xml"
    url = "http://svn.com/"
    name = "Signal vs. Noise"

    form = create(:subscribe_form, slug: "signal-vs-noise", feed_url: feed_url, url: url, name: name)
    create(:site, subscribe_form_id: form.id, feed_url: feed_url, url: url, name: name)

    visit "/s/signal-vs-noise"

    fill_in "email", with: "jankees@hotmail.com"
    # expect { click_on "Subscribe" }.to change { User.last.feeds.count }.by(1)
    click_on "Subscribe"
    expect(User.count).to eq 2
    expect(User.last.feeds.count).to eq 1
    new_user = User.last

    expect(new_user.email).to eq "jankees@hotmail.com"
    expect(new_user.feeds.first.feed_url).to eq feed_url
    expect(new_user.feeds.first.url).to eq url
    expect(new_user.feeds.first.name).to eq name
    expect(new_user.feeds.first.subscribe_form).to eq form
  end

  it "gives an error for existing users" do
    create(:subscribe_form, slug: "signal-vs-noise")
    user_email = "jankees@hotmail.com"
    create(:user, email: user_email)

    visit "/s/signal-vs-noise"

    fill_in "email", with: user_email
    click_on "Subscribe"

    expect(page).to have_content "You already have an account"
  end

  it "does not create an account for an invalid email address" do
    create(:subscribe_form, slug: "signal-vs-noise")

    visit "/s/signal-vs-noise"

    fill_in "email", with: "jankees@h"

    expect { click_on "Subscribe" }.to change { User.count }.by(0)
    expect(page).to have_content "Invalid email address"
  end
end
