require "rails_helper"

describe EmailUsersJob do
  it "enqueues a mailer at the right time" do
    create(:user, send_email_at: 9.hours)

    EmailUsersJob.perform_now

    expect(Delayed::Job.all).to have(1).job

    job = Delayed::Job.first
    expect(job.run_at).to eq Time.zone.today.midnight.advance(hours: 9)
    expect(job.priority).to eq 0
  end

  it "sends the email by default at 6 am" do
    create(:user, send_email_at: nil)

    EmailUsersJob.perform_now

    expect(Delayed::Job.all).to have(1).job

    job = Delayed::Job.first
    expect(job.run_at).to eq Time.zone.today.midnight.advance(hours: 6)
    expect(job.priority).to eq 0
  end

  it "does not enqueue a job for someone who unsubscribed" do
    create(:user, :unsubscribed)

    EmailUsersJob.perform_now

    expect(Delayed::Job.all).to have(0).jobs
  end
end
