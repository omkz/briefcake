class BriefCakeTransitionController < ApplicationController
  def has_seen_briefcake
    session[:has_seen_briefcake] = true
    redirect_to params.require(:path), fallback_location: root_path
  end
end
