require 'test_helper'


class ImportControllerTest < ActionController::TestCase
  setup do
    sign_in(users(:first))
  end

  test "GET #new returns success" do
    get :new
    assert response.status
  end

  test "GET #create returns success" do
    get :create
    assert response.status
  end
end
