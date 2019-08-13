require "rails_helper"

feature "sending emails" do
  before :each do
    expect(ActionMailer::Base.deliveries).to have(0).deliveries
  end

  it "sends emails when there are new items, but only with the new items" do
    date_between_posts = Time.local(2015, 9, 19, 10, 5)

    Timecop.travel(date_between_posts) do
      feed = nil
      user = create(:user)

      VCR.use_cassette("timi-blog-1") do
        feed = timi_blog_feed(user)
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

      expect(SentEmail).to have(1).record
      sent_email = SentEmail.last
      expect(sent_email.subject).to eq "RSSMailer – 1 new items on 2015-09-19"
      expect(sent_email.number_of_items).to eq 1
      expect(sent_email.index).to eq({ "Timi blog" => 1 })
      expect(sent_email.receiver).to eq user.email
      expect(sent_email.user).to eq user
      expect(sent_email.compose_duration_in_seconds).to be > 0

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

      expect(SentEmail).to have(2).record
      sent_email = SentEmail.last
      expect(sent_email.subject).to eq "RSSMailer – 2 new items on 2015-09-19"
      expect(sent_email.number_of_items).to eq 2
      expect(sent_email.index).to eq({ "Timi blog" => 2 })
      expect(sent_email.receiver).to eq user.email
      expect(sent_email.user).to eq user
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
           feed_url: "https://timiapp.com/blog.rss",
           publish_date_last_sent_item: nil)
  end
end
