class Feed < ApplicationRecord
  friendly_id :name, use: :slugged

  belongs_to :user
end
