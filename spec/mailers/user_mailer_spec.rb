require "rails_helper"

describe UserMailer, type: :mailer do
  it "does only send one email per day" do
    user = create(:user)
    feed = create(:feed, user: user)

    Timecop.travel(Time.local(2019, 9, 20, 9, 0))

    expect {
      feed_item = build(:feed_item, feed: feed, publish_date: 1.hour.from_now)
      allow_any_instance_of(Feed).to receive(:new_items!).and_return([feed_item])
      NewsletterJob.new.perform(user.id)
    }.to change(ActionMailer::Base.deliveries, :count).by(1)

    Timecop.travel(1.hour)

    expect {
      feed_item = build(:feed_item, feed: feed, publish_date: 1.hour.from_now)
      allow_any_instance_of(Feed).to receive(:new_items!).and_return([feed_item])
      NewsletterJob.new.perform(user.id)
    }.to_not change(ActionMailer::Base.deliveries, :count)

    Timecop.travel(3.days)

    expect {
      feed_item = build(:feed_item, feed: feed, publish_date: 1.hour.from_now)
      allow_any_instance_of(Feed).to receive(:new_items!).and_return([feed_item])
      NewsletterJob.new.perform(user.id)
    }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
