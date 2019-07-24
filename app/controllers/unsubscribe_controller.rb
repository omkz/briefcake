class UnsubscribeController < ApplicationController
  def destroy
    email = params[:e]
    token = params[:t]
    @resubscribe = params[:on] == "true"

    @user = User.find_by(email: email)

    if @user.present?
      if @user.unsubscribe_token == token
        if @resubscribe
          @user.update_column(:unsubscribed_at, nil)
        else
          @user.update_column(:unsubscribed_at, Time.zone.now)
        end
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end
