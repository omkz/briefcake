class SubscribeFormController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def edit
    @subscribe_form = subscribe_form
    @subscribe_form.sites.build if @subscribe_form.sites.count == 0
    @preview_path = preview_feeds_url(feed: {feed_url: @subscribe_form.sites.first&.feed_url, url: @subscribe_form.sites.first&.url,  name: @subscribe_form.name})
  end

  def update
    form_params = subscribe_form_params
    form_params[:slug] = form_params[:slug]&.parameterize

    @subscribe_form = subscribe_form
    if @subscribe_form.update(form_params)
      redirect_to edit_subscribe_form_path, notice: "Form was successfully updated."
    else
      render :edit
    end
  end

  private

  def subscribe_form
    current_user.subscribe_form.presence || current_user.build_subscribe_form
  end

  def subscribe_form_params
    # params.require(:subscribe_form).permit(:url, :slug, :name, :feed_url, :color, sites_attributes: [:url, :feed_url])
    params.require(:subscribe_form).permit(:slug, :name, :color, sites_attributes: [:_destroy, :url, :feed_url, :id, :name])
  end
end
