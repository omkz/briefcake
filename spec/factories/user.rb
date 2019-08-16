FactoryBot.define do
  factory :user do
    first_name { "Simple" }
    last_name { "Joe" }
    sequence (:email) { |i| "email+#{i}@example.com" }
    password { "secret" }
    unsubscribed_at { nil }
    confirmed_at { Time.zone.now }
  end
end
