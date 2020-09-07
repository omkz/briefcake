# Preview all emails at http://localhost:3000/rails/mailers/bot_report
class BotReportPreview < ActionMailer::Preview
    def report
        BotReportMailer.with(humans: 10, bots: 10).report
    end
end
