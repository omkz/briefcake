class User < ApplicationRecord
  include Sjabloon::Stripe::Payer
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :masqueradable,
         :confirmable

  has_person_name
  has_many :announcements
  has_many :feeds
  has_many :sent_emails

  scope :who_want_emails, -> { where(unsubscribed_at: nil) }

  validates :name, presence: true

  def email_with_name
    name + " <#{email}>"
  end

  def wants_email?
    unsubscribed_at.nil?
  end

  def unsubscribe_url
    Rails.application.routes.url_helpers.unsubscribe_url + "?t=" + unsubscribe_token + "&e=" + email
  end

  def resubscribe_url
    Rails.application.routes.url_helpers.unsubscribe_url + "?t=" + unsubscribe_token + "&e=" + email + "&on=true"
  end

  def unsubscribe_token
    Digest::MD5.hexdigest(id.to_s + created_at.to_s)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
