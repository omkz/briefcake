class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = current_user.feeds.all
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
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
        format.html { redirect_to @feed, notice: "Feed was successfully updated." }
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
    @feed = current_user.feeds.friendly.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:name, :url, :user_id)
  end
end
