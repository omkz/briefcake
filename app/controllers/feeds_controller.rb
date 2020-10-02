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
        render "user_mailer/new_items", layout: "mailer"
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
    render json: page_info.to_json
  end

  # GET /feeds/new
  def new
    @feed = current_user.feeds.new
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
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "Feed was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_feed
    @feed = current_user.feeds.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:name, :url, :feed_url, :truncation, :fetch_error)
  end

  def export
  end
  
end
