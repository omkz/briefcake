class FeedItem
  include ActiveModel::Model

  attr_accessor :title,
                :description,
                :link,
                :feed_id,
                :image_url,
                :publish_date,
                :feed

  def link
    if @link.blank?
      feed.url
    else
      @link
    end
  end
end
