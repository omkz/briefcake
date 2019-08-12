FactoryBot.define do
  factory :feed do
    user
    name { "Timi blog" }
    url { "https://timiapp.com/blog" }
    feed_url { "https://timiapp.com/blog.rss" }

    trait :with_fetch_error do
      fetch_error { "Can not read XML" }
    end
  end
end
