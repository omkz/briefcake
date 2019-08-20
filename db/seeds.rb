Feed.destroy_all
User.destroy_all
SubscribeForm.destroy_all
SentEmail.destroy_all
Delayed::Job.delete_all

user = FactoryBot.create(:user, email: "email@domain.com", password: "password")

FactoryBot.create(:feed, "name": "Ars Technica", "url": "https://arstechnica.com/", "user_id": user.id, "feed_url": "http://feeds.arstechnica.com/arstechnica/index/", "publish_date_last_sent_item": 2.days.ago, "truncation": nil)
FactoryBot.create(:feed, "name": "Signal v. Noise", "url": "https://m.signalvnoise.com/", "user_id": user.id, "feed_url": "https://m.signalvnoise.com/feed/", "publish_date_last_sent_item": 2.days.ago, "truncation": 0)
FactoryBot.create(:feed, "name": "MacRumors: Apple Mac iPhone Rumors and News", "url": "https://www.macrumors.com", "user_id": user.id, "feed_url": "http://feeds.macrumors.com/MacRumors-All", "publish_date_last_sent_item": 2.days.ago, "truncation": 0)
FactoryBot.create(:feed, "name": "Timo Kuilder", "url": "https://www.instagram.com/zwartekoffie/", "user_id": user.id, "feed_url": "https://www.instagram.com/zwartekoffie/", "publish_date_last_sent_item": 10.days.ago)
FactoryBot.create(:feed, "name": "The New York Times", "url": "https://www.nytimes.com/", "user_id": user.id, "feed_url": "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", "publish_date_last_sent_item": 2.days.ago, "truncation": nil)
FactoryBot.create(:feed, "name": "Marques Brownlee - YouTube", "url": "https://www.youtube.com/channel/UCBJycsmduvYEL83R_U4JriQ", "user_id": user.id, "feed_url": "https://www.youtube.com/feeds/videos.xml?channel_id=UCBJycsmduvYEL83R_U4JriQ", "publish_date_last_sent_item": 14.days.ago, "truncation": nil)
FactoryBot.create(:feed, :with_fetch_error, "name": "Example", "url": "https://www.example.com", "user_id": user.id, "feed_url": "https://xxxx.xxxxx", "publish_date_last_sent_item": 14.days.ago, "truncation": nil)

FactoryBot.create(:subscribe_form, user: user)
