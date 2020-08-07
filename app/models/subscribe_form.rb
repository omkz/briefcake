class SubscribeForm < ApplicationRecord
  validates :slug, uniqueness: true, presence: true
  validates :name, presence: true
  belongs_to :user
  has_many :sites, dependent: :destroy
  # accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc { |attr| attr['description'].blank? }
  accepts_nested_attributes_for :sites, allow_destroy: true
end
