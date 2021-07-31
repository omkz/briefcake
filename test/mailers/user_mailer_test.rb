require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "does only send one email per day" do
    user = create(:user)
    feed = create(:feed, user: user)

    Timecop.travel(Time.local(2019, 9, 20, 9, 0))

    assert_difference -> { ActionMailer::Base.deliveries.count} do
      feed_item = build(:feed_item, feed: feed, publish_date: 1.hour.from_now)
      Feed.stub_any_instance(:new_items!, [feed_item]) do
        NewsletterJob.new.perform(user.id)
      end
    end

    Timecop.travel(1.hour)

    assert_no_difference -> { ActionMailer::Base.deliveries.count} do
      feed_item = build(:feed_item, feed: feed, publish_date: 1.hour.from_now)
      Feed.stub_any_instance(:new_items!, [feed_item]) do
        NewsletterJob.new.perform(user.id)
      end
    end

    Timecop.travel(3.days)

    assert_difference -> { ActionMailer::Base.deliveries.count} do
      feed_item = build(:feed_item, feed: feed, publish_date: 1.hour.from_now)
      Feed.stub_any_instance(:new_items!, [feed_item]) do
        NewsletterJob.new.perform(user.id)
      end
    end
  end
end
