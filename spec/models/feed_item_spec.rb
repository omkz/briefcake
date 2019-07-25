require "rails_helper"

describe FeedItem do
  describe "#publish_date" do
    it "sets the publish_date if its not present" do
      feed_item = create(:feed_item, publish_date: nil)
      expect(feed_item.publish_date).to be_today
    end

    it "doesnt set the publish date if it's present" do
      one_week_ago = 1.week.ago

      feed_item = create(:feed_item, publish_date: one_week_ago)
      expect(feed_item.publish_date).to eq one_week_ago
    end
  end

  describe "#link" do
    it "always has a link" do
      feed = create(:feed, created_at: 1.month.ago, url: "https://feedslink.com")
      without_link = create(:feed_item, link: nil, feed: feed)
      with_link = create(:feed_item, link: "https://itemslink.com", feed: feed)

      expect(with_link.link).to eq "https://itemslink.com"
      expect(without_link.link).to eq "https://feedslink.com"
    end
  end

  describe "#unseed" do
    it "returns all items that are not sent" do
      feed = create(:feed, created_at: 1.month.ago)
      create(:feed_item, :sent, feed: feed)
      create(:feed_item, feed: feed)
      create(:feed_item, feed: feed)

      expect(feed.feed_items.unseen_items).to have(2).item
    end

    it "returns items published after the day the feed is created" do
      feed = create(:feed, created_at: 1.week.ago)
      old_item = create(:feed_item, feed: feed, publish_date: 1.year.ago)
      new_item = create(:feed_item, feed: feed)

      expect(feed.feed_items.unseen_items).to include new_item
      expect(feed.feed_items.unseen_items).not_to include old_item
    end

    it "can get the unseen_items for a user" do
      user_a = create(:user)
      user_b = create(:user)
      feed_a = create(:feed, user: user_a, created_at: 1.month.ago)
      feed_b = create(:feed, user: user_b, created_at: 1.month.ago)
      create(:feed_item, feed: feed_a)
      create(:feed_item, feed: feed_b)
      create(:feed_item, feed: feed_b)

      expect(user_a.feed_items.unseen_items).to have(1).item
      expect(user_b.feed_items.unseen_items).to have(2).item
    end
  end
end
