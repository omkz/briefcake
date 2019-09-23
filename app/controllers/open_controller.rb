class OpenController < ApplicationController
  def show
  end

  def jobs
    @jobs = Delayed::Job.all
    @todays_emails = SentEmail.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    render layout: "clean"
  end
end
