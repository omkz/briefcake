class FetchFeedsJob < ApplicationJob
  queue_as :default

  def perform
    Feed.all.find_each { |feed| FetchFeedItemsJob.perform_later(feed.id) }
  end
end
