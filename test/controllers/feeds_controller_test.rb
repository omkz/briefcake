require 'test_helper'


class FeedsControllerTest < ActionController::TestCase
  setup do
    @user = users(:first)
    sign_in(@user)
  end

  test "GET #index returns success" do
    get :index
    assert response.status
  end

  test "GET #index return xml" do
    get :index, format: :xml
    assert response.status
    assert_equal 'text/xml', response.content_type
  end


  test "POST #create: add new feed" do
    assert_difference -> { @user.feeds.count } do
      VCR.use_cassette('johnnunemaker rss') do
        post :create, params: { feed:
          { name: 'john',
            url: "https://www.johnnunemaker.com",
            feed_url: "https://www.johnnunemaker.com/rss/",
            truncation: ''
          }}
        feed = @user.feeds.where(url: "https://www.johnnunemaker.com").first

        assert response.status
        assert_equal(DateTime.new(2021, 6, 21, 15, 48, 52), feed.publish_date_last_sent_item)
      end
    end
  end
end
