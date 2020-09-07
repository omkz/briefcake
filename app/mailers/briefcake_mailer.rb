class BriefcakeMailer < ApplicationMailer
    def transition_email
        raise ArgumentError if params[:user].nil? 
        @user = params[:user]
        mail(to: @user.email, subject: "RSSMailer is now 🍰 Briefcake!")
    end
end
