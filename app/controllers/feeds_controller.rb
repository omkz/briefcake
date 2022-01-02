class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :preview
  layout "dashboard"

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = current_user.feeds.all
    respond_to do |format|
      format.html
      format.xml {
        send_data render_to_string(template: "feeds/index"),
        type: "text/xml",
        filename: "feeds.opml"
      }
    end
  end

  def preview
    if params[:feed].blank?
      render status: :no_content
      return
    end

    @user = current_user

    @fetch = params[:fetch] === "true"
    if @fetch
      @feed = Feed.new(feed_params)
      @feed_items = FeedReader.new(@feed).fetch_items!

      if @feed_items.any?
        render "user_mailer/newsletter", layout: "mailer"
      else
        @error = true
        render layout: "clean"
      end
    else
      @params = feed_params
      render layout: "clean"
    end
  end


  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  def check
    page_info = PageInfoFinder.new(params[:url]).fetch!

    MIXPANEL.track(current_user.id, "page check", {
      'url' => page_info.url,
      'feed_url' => page_info.feed_url,
      'name' => page_info.name
    })

    render json: page_info.to_json
  rescue PageInfoFinder::NotFoundError
    
    render json: {:name=>"Feed not found"}
  end

  # GET /feeds/new
  def new
    @feed = current_user.feeds.new(url: feed_url_params)
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = current_user.feeds.new(feed_params)

    respond_to do |format|
      if @feed.save
        MIXPANEL.track(current_user.id, 'add feed', feed_params.to_h)
        format.html { redirect_to feeds_url, notice: "Feed was successfully created." }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        @feed.update_column(:fetch_error, nil)
        MIXPANEL.track(current_user.id, 'update feed', feed_params.to_h)

        format.html { redirect_to feeds_path, notice: "Feed was successfully updated." }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy

    MIXPANEL.track(current_user.id, 'destroy',{
      'url' => @feed.url,
      'feed_url' => @feed.feed_url,
      'name' => @feed.name
    })
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "Feed was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def feed_url_params
    params.permit(:url)["url"]
  end

  def set_feed
    @feed = current_user.feeds.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:name, :url, :feed_url, :truncation, :fetch_error)
  end
end
