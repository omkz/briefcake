class BriefCakeTransitionController < ApplicationController
  def has_seen_briefcake
    session[:has_seen_briefcake] = true
    redirect_to root_path
  end
end
