FactoryBot.define do
  factory :feed do
    user
    name { "Timi blog" }
    url { "https://timiapp.com/blog" }
    rss_feed_url { "https://timiapp.com/blog.rss" }
  end
end
