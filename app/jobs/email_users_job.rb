class EmailUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.who_get_emails.find_each do |user|
      picked_specific_time = user.send_email_at.present?
      run_at = if picked_specific_time
                 result = user.send_email_at.in_time_zone(user.time_zone).utc
                 result.to_date == Date.yesterday ? result + 24.hours : result
               else
                 Time.zone.now.at_midnight + 6.hours
               end

      UserMailer.delay(queue: "new_items", priority: picked_specific_time ? 5 : 10, run_at: run_at).new_items(user.id)
    end
  end
end
