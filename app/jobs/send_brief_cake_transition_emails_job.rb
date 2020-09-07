class SendBriefCakeTransitionEmailsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.who_get_emails.find_each do |user|
      BriefcakeMailer.with(user:user).transition_email.deliver_later
    end
    # Do something later
  end
end
