require "rails_helper"

feature "sending emails" do
  before :each do
    expect(ActionMailer::Base.deliveries).to have(0).deliveries
  end

  it "sends emails when there are new items, but only with the new items" do
    date_between_posts = Time.local(2015, 9, 19, 10, 5)

    Timecop.travel(date_between_posts) do
      feed = nil

      VCR.use_cassette("timi-blog-1") do
        feed = timi_blog_feed(create(:user))
      end

      VCR.use_cassette("timi-blog-1") do
        EmailUsersJob.perform_now
      end

      expect(ActionMailer::Base.deliveries).to have(0).deliveries
      expect(feed.reload.publish_date_last_sent_item).to eq Time.utc(2015, 9, 18)

      VCR.use_cassette("timi-blog-2") do
        EmailUsersJob.perform_now
      end

      expect(feed.reload.publish_date_last_sent_item).to eq Time.utc(2015, 10, 4)

      deliveries = ActionMailer::Base.deliveries
      email = deliveries.first

      expect(deliveries).to have(1).delivery
      expect(email).not_to have_body_text(/first item in feed/)
      expect(email).to have_body_text(/second item in feed/)

      VCR.use_cassette("timi-blog-3") do
        EmailUsersJob.perform_now
      end

      expect(feed.reload.publish_date_last_sent_item).to eq Time.utc(2016, 10, 4)

      deliveries = ActionMailer::Base.deliveries
      email = deliveries.last

      expect(deliveries).to have(2).deliveries
      expect(email).not_to have_body_text(/first item in feed/)
      expect(email).not_to have_body_text(/second item in feed/)
      expect(email).to have_body_text(/third item in feed/)
      expect(email).to have_body_text(/fourth item in feed/)

      VCR.use_cassette("timi-blog-3") do
        EmailUsersJob.perform_now
      end

      expect(ActionMailer::Base.deliveries).to have(2).deliveries
    end
  end

  it "sends an email when there is are new items (order in feed inverted)" do
    date_between_posts = Time.local(2015, 9, 19, 10, 5)

    Timecop.travel(date_between_posts) do
      feed = nil

      VCR.use_cassette("timi-blog-1") do
        feed = timi_blog_feed(create(:user))
      end

      VCR.use_cassette("timi-blog-1") do
        EmailUsersJob.perform_now
      end

      expect(ActionMailer::Base.deliveries).to have(0).deliveries

      VCR.use_cassette("timi-blog-2-rev") do
        EmailUsersJob.perform_now
      end

      deliveries = ActionMailer::Base.deliveries
      email = deliveries.first

      expect(deliveries).to have(1).delivery
      expect(email).not_to have_body_text(/first item in feed/)
      expect(email).to have_body_text(/second item in feed/)
    end
  end

  def timi_blog_feed(user)
    create(:feed,
           user: user,
           name: "Timi blog",
           url: "https://timiapp.com/blog",
           rss_feed_url: "https://timiapp.com/blog.rss")
  end
end
