class ApplicationMailer < ActionMailer::Base
  default from: "RSSMailer <no-reply@rssmailer.app>"
  layout "mailer"
end
