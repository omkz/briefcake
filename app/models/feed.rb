class Feed < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :url, url: true
  validates :name, presence: true

  has_many :feed_items, dependent: :destroy
  belongs_to :user
end
