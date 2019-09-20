class EmailUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.who_get_emails.find_each do |user|
      midnight = Time.zone.now.at_midnight
      run_at = midnight + (user.send_email_at.presence || 6.hours)
      UserMailer.delay(queue: "new_items", priority: 10, run_at: run_at).new_items(user.id)
    end
  end
end
