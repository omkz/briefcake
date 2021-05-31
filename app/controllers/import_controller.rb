class ImportController < ApplicationController
  layout 'dashboard'

  def new
  end

  def create
    @feeds = OpmlReader.new(params[:opml_file].read).feeds
    @number_of_new_feeds = 0

    @feeds.map do |feed|
      feed.user = current_user

      if feed.save
        @number_of_new_feeds += 1
      end
    end

    if @number_of_new_feeds == 0
      raise :no_feeds
    else
      redirect_to feeds_url, notice: "Imported #{@number_of_new_feeds} feeds!"
    end

  rescue
    @error_while_importing = true
    render :new
  end
end
