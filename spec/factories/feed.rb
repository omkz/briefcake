FactoryBot.define do
  factory :feed do
    user
    name { "Timi blog" }
    url { "https://timiapp.com/blog" }
    feed_url { "https://timiapp.com/blog.rss" }
    publish_date_last_sent_item { 1.day.ago }

    trait :with_fetch_error do
      fetch_error { "Can not read XML" }
    end
  end
end
