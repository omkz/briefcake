FactoryBot.define do
  factory :subscribe_form do
    user
    feed_url { "https://timiapp.com/blog.xml" }
    url { "https://timiapp.com/blog" }
    slug { "timi" }
    name { "Timi" }
  end
end
