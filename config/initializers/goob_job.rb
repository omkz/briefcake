GoodJob.preserve_job_records = false
GoodJob.retry_on_unhandled_error = false
GoodJob.on_thread_error = -> (exception) { Honeybadger.notify(exception) }

ActionMailer::MailDeliveryJob.retry_on StandardError, wait: :exponentially_longer, attempts: Float::INFINITY

# With Sentry (or Bugsnag, Airbrake, Honeybadger, etc.)
ActionMailer::MailDeliveryJob.around_perform do |_job, block|
  block.call
rescue StandardError => e
  Honeybadger.notify(e)
  raise
end