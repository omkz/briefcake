FactoryBot.define do
  factory :feed_item do
    feed
    title { "The hardest leadership advice" }
    description { "We all know we’re supposed to “work on the business and not in the business” as a leader… but what holds us back?" }
    sequence(:link) { |i| "https://m.signalvnoise.com/the-hardest-leadership-advice-to-follow/#{i}" }
    publish_date { Time.zone.yesterday }

    trait :sent do
      sent_at { Time.zone.yesterday }
    end
  end
end
