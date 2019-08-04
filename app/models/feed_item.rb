class FeedItem
  include ActiveModel::Model

  attr_accessor :title,
                :description,
                :link,
                :image_url,
                :publish_date,
                :feed

  def description
    if self.feed.try(:truncation).present?
      if self.feed.truncation === 0
        nil
      else
        @description.to_s.truncate(self.feed.truncation)
      end
    else
      @description
    end
  end

  def link
    if @link.blank?
      feed.url
    else
      @link
    end
  end
end
