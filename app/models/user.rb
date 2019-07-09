class User < ApplicationRecord
  include Sjabloon::Stripe::Payer
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :masqueradable

  has_person_name
  has_many :announcements
  has_many :feeds

  validates :name, presence: true

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
