class BotReportMailer < ApplicationMailer
    def report
        raise ArgumentError if params[:humans].nil? or params[:bots].nil?
        @humans = params[:humans]
        @bots = params[:bots]
        mail(to: "spam@factorialwebdevelopment.com", subject: "Bot report")
    end
end
