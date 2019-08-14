class SubscribeController < ApplicationController
  layout "clean"

  def show
    @subscribe_form = SubscribeForm.find_by!(slug: params[:slug])
    @user = User.new
  end

  def subscribe
    @subscribe_form = SubscribeForm.find_by_slug!(params[:slug])
    @user = User.new(email: params[:email])
    @user.password = SecureRandom.urlsafe_base64

    feed = Feed.new
    feed.url = @subscribe_form.url
    feed.feed_url = @subscribe_form.feed_url
    feed.name = @subscribe_form.name
    feed.user = @user
    feed.subscribe_form = @subscribe_form

    if @user.save && feed.save
      render :subscribe
    else
      render :show
    end
  end
end
