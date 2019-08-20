class SubscribeForm < ApplicationRecord
  validates :url, url: true, presence: true
  validates :feed_url, url: true, presence: true
  validates :slug, uniqueness: true, presence: true
  validates :name, presence: true
  belongs_to :user
end
