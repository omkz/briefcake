require "application_system_test_case"

require "minitest-matchers"
require "email_spec"

class MailSendingTest < ApplicationSystemTestCase
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  setup do
    ActionMailer::Base.deliveries.clear
    assert_equal(0, ActionMailer::Base.deliveries.count)
  end

  test "sends emails when there are new items, but only with the new items" do
    date_between_posts = Time.local(2015, 9, 19, 10, 5)

    Timecop.travel(date_between_posts) do
      feed = nil
      user = create(:user)

      VCR.use_cassette("timi-blog-1") do
        feed = timi_blog_feed(user)
      end

      VCR.use_cassette("timi-blog-1") do
        NewsletterJob.new.perform(feed.user.id)
      end

      assert_equal(0, ActionMailer::Base.deliveries.count)
      assert_equal(Time.utc(2015, 9, 18), feed.reload.publish_date_last_sent_item)

      VCR.use_cassette("timi-blog-2") do
        NewsletterJob.new.perform(feed.user.id)
      end

      assert_equal(Time.utc(2015, 10, 4), feed.reload.publish_date_last_sent_item)

      deliveries = ActionMailer::Base.deliveries
      email = deliveries.first

      assert_equal(1, deliveries.count)
      email.html_part.body.to_s.tap do |body|
        refute_match(/first item in feed/, body)
        assert_match(/second item in feed/, body)
      end

      assert_equal(1, SentEmail.count)

      sent_email = SentEmail.last
      assert_equal("Briefcake – 1 new item on 2015-09-19", sent_email.subject)
      assert_equal(1, sent_email.number_of_items)
      assert_equal({ "Timi blog" => 1 }, sent_email.index)
      assert_equal(user.email, sent_email.receiver)
      assert_equal(user, sent_email.user)

      Timecop.travel 1.day.from_now

      VCR.use_cassette("timi-blog-3") do
        NewsletterJob.new.perform(feed.user.id)
      end

      assert_equal(Time.utc(2016, 10, 4), feed.reload.publish_date_last_sent_item)

      deliveries = ActionMailer::Base.deliveries
      email = deliveries.last

      assert_equal(2, deliveries.count)

      refute_match(/first item in feed/, email.html_part.body.to_s)
      assert have_body_text(/second item in feed/), email
      assert have_body_text(/second item in feed/), email
      assert have_body_text(/third item in feed/), email
      assert have_body_text(/fourth item in feed/), email

      VCR.use_cassette("timi-blog-3") do
        NewsletterJob.new.perform(feed.user.id)
      end

      assert_equal(2, ActionMailer::Base.deliveries.size)

      assert_equal(2, SentEmail.count)
      sent_email = SentEmail.last
      assert_equal("Briefcake – 2 new items on 2015-09-20", sent_email.subject)
      assert_equal(2, sent_email.number_of_items)
      assert_equal({ "Timi blog" => 2 }, sent_email.index)
      assert_equal(user.email, sent_email.receiver)
      assert_equal(user, sent_email.user)
    end
  end

  test "sends an email when there is are new items (order in feed inverted)" do
    date_between_posts = Time.local(2015, 9, 19, 10, 5)

    Timecop.travel(date_between_posts) do
      feed = nil

      VCR.use_cassette("timi-blog-1") do
        feed = timi_blog_feed(create(:user))
      end

      VCR.use_cassette("timi-blog-1") do
        NewsletterJob.new.perform(feed.user.id)
      end

      assert_equal(0, ActionMailer::Base.deliveries.size)

      VCR.use_cassette("timi-blog-2-rev") do
        NewsletterJob.new.perform(feed.user.id)
      end

      deliveries = ActionMailer::Base.deliveries
      email = deliveries.first

      assert_equal(1, deliveries.size)
      refute_match(/first item in feed/, email.html_part.body.to_s)
      assert have_body_text(/second item in feed/), email
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
