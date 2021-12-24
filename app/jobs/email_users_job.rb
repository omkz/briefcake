class EmailUsersJob < ApplicationJob
  queue_as :low

  def perform(*args)
    User.who_get_emails.find_each do |user|
      NewsletterJob
        .set(priority: user.priority, wait_until: user.run_at)
        .perform_later(user.id)
    end
  end
end
