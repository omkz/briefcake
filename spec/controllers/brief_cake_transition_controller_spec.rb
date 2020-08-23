require 'rails_helper'

RSpec.describe BriefCakeTransitionController, type: :controller do

  describe "GET #has_seen_briefcake" do
    it "returns http success" do
      get :has_seen_briefcake
      expect(response).to have_http_status(:success)
    end
  end

end
