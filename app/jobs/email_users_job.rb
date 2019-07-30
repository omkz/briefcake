class EmailUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.who_want_emails.find_each do |user|
      UserMailer.new_items(user.id).deliver_later
    end
  end
end
