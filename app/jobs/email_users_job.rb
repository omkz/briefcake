class EmailUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.who_get_emails.find_each do |user|
      begin
        UserMailer.delay(
          queue: "new_items",
          priority: user.priority,
          run_at: user.run_at).new_items(user.id)
      rescue => e
        Honeybadger.notify(e)
      end
    end
  end
end
