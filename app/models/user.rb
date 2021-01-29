class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :masqueradable,
         :confirmable

  validates :email, presence: true, 'valid_email_2/email': { disposable: true }

  has_person_name
  has_many :announcements
  has_many :feeds, dependent: :destroy
  has_many :sent_emails
  has_one :subscribe_form, dependent: :destroy

  scope :who_get_emails, -> { where(unsubscribed_at: nil).where.not(confirmed_at: nil) }
  scope :unsubscribed, -> { where.not(unsubscribed_at: nil) }

  def email_with_name
    name.to_s + " <#{email}>"
  end

  def priority
    custom_timing? ? 5 : 10
  end

  def run_at
    if custom_timing?
      result = send_email_at.in_time_zone(time_zone).utc
      result.to_date == Date.yesterday ? result + 24.hours : result
    else
      Time.zone.now.at_midnight + 6.hours
    end
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

  private

  def custom_timing?
    send_email_at.present?
  end
end
