class EmailUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.who_get_emails.find_each do |user|
      UserMailer.new_items(user.id).deliver_later(queue: "new_items", priority: 10)
    end
  end
end
