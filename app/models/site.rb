class Site < ApplicationRecord
  validates :url, url: true, presence: true
  validates :feed_url, url: true, presence: true
  belongs_to :subscribe_form
end
