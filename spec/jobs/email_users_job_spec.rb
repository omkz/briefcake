require "rails_helper"

describe EmailUsersJob do
  it "enqueues a mailer at the right time" do
    create(:user, send_email_at: "9:00")

    EmailUsersJob.perform_now

    expect(Delayed::Job.all).to have(1).job

    job = Delayed::Job.first
    expect(job.run_at).to eq Time.zone.today.midnight.advance(hours: 9)
    expect(job.priority).to eq 10
  end

  it "sends the email by default at 6 am" do
    create(:user, send_email_at: nil)

    EmailUsersJob.perform_now

    expect(Delayed::Job.all).to have(1).job

    job = Delayed::Job.first
    expect(job.run_at).to eq Time.zone.today.midnight.advance(hours: 6)
    expect(job.priority).to eq 10
  end

  it "uses the users timezone to determine the time" do
    Timecop.freeze Time.zone.parse("2019-09-23 00:00:00") do
      create(:user, send_email_at: "9:00", time_zone: "Amsterdam")

      EmailUsersJob.perform_now

      expect(Delayed::Job.all).to have(1).job

      job = Delayed::Job.first
      expect(job.run_at).to eq Time.zone.today.midnight.advance(hours: 7)
      expect(job.priority).to eq 10
    end
  end

  describe "time_zones" do
    it "uses the timezone to determine the time" do
      Timecop.freeze Time.zone.parse("2019-09-23 00:00:00") do
        create(:user, send_email_at: "9:00", time_zone: "Amsterdam")

        EmailUsersJob.perform_now

        expect(Delayed::Job.all).to have(1).job

        job = Delayed::Job.first
        expect(job.run_at.to_s).to eq "2019-09-23 07:00:00 UTC"
        expect(job.priority).to eq 10
      end
    end

    it "works when the job runs later" do
      Timecop.freeze Time.zone.parse("2019-09-23 16:00:00") do
        create(:user, send_email_at: "23:00", time_zone: "Sydney")

        EmailUsersJob.perform_now

        expect(Delayed::Job.all).to have(1).job

        job = Delayed::Job.first
        expect(job.run_at.to_s).to eq "2019-09-24 13:00:00 UTC"
        expect(job.priority).to eq 10
      end
    end

    it "uses the timezone to determine the time (for Mountain Time (US & Canada))" do
      Timecop.freeze Time.zone.parse("2019-09-23 00:00:00") do
        create(:user, send_email_at: "9:00", time_zone: "Mountain Time (US & Canada)")

        EmailUsersJob.perform_now

        expect(Delayed::Job.all).to have(1).job

        job = Delayed::Job.first
        expect(job.run_at.to_s).to eq "2019-09-23 15:00:00 UTC"
        expect(job.priority).to eq 10
      end
    end

    it "uses the timezone to determine the time (for Sydney)" do
      Timecop.freeze Time.zone.parse("2019-09-23 00:00:00") do
        create(:user, send_email_at: "14:00", time_zone: "Sydney")

        EmailUsersJob.perform_now

        expect(Delayed::Job.all).to have(1).job

        job = Delayed::Job.first
        expect(job.run_at.to_s).to eq "2019-09-23 04:00:00 UTC"
        expect(job.priority).to eq 10
      end
    end

    it "uses the timezone to determine the time (for Sydney at midnight)" do
      Timecop.freeze Time.zone.parse("2019-09-23 00:00:00") do
        create(:user, send_email_at: "00:00", time_zone: "Sydney")

        EmailUsersJob.perform_now

        expect(Delayed::Job.all).to have(1).job

        job = Delayed::Job.first
        expect(job.run_at.to_s).to eq "2019-09-23 14:00:00 UTC"
        expect(job.priority).to eq 10
      end
    end

    it "uses the timezone to determine the time (for American Samoa at 16:00)" do
      Timecop.freeze Time.zone.parse("2019-09-23 00:00:00") do
        create(:user, send_email_at: "16:00", time_zone: "American Samoa")

        EmailUsersJob.perform_now

        expect(Delayed::Job.all).to have(1).job

        job = Delayed::Job.first
        expect(job.run_at.to_s).to eq "2019-09-23 03:00:00 UTC"
        expect(job.priority).to eq 10
      end
    end
  end

  it "does not enqueue a job for someone who unsubscribed" do
    create(:user, :unsubscribed)

    EmailUsersJob.perform_now

    expect(Delayed::Job.all).to have(0).jobs
  end

  it "does not enqueue jobs for unconfirmed users" do
    create(:user, :unconfirmed)

    EmailUsersJob.perform_now

    expect(Delayed::Job.all).to have(0).jobs
  end
end
