class SubscribeController < ApplicationController
  layout "briefcake/application"

  def show
    @subscribe_form = SubscribeForm.find_by!(slug: params[:slug])
    @user = User.new
  end

  def subscribe
    @subscribe_form = SubscribeForm.find_by_slug!(params[:slug])
    @user = User.new(email: params[:email])
    @user.password = SecureRandom.urlsafe_base64

    @subscribe_form.sites.each do |site|
      feed = Feed.new
      feed.url = site.url
      feed.feed_url = site.feed_url
      feed.name = site.name
      feed.user = @user
      feed.subscribe_form = @subscribe_form
      # render :show and return unless feed.save
      feed.save
    end

    if @user.save
      render :subscribe
    else
      render :show
    end
  end
end
