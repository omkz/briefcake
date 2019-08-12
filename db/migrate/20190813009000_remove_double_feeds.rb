class RemoveDoubleFeeds < ActiveRecord::Migration[5.2]
  def up
    feed_delete_count = 0

    Feed.all.find_each do |feed|
      feed.reload
      if !feed.valid? && feed.errors.added?(:feed_url, "has already been taken")
        feed.destroy!

        say "Duplicate feeds: "
        duplicates = Feed.where(user_id: feed.user_id, feed_url: feed.feed_url)
        duplicates.each do |dup|
          say "  #{dup.id} #{dup.user_id} #{dup.name} #{dup.url} #{dup.feed_url}"
        end

        feed_delete_count += 1
      end
    end

    say "Destroyed #{feed_delete_count} duplicate feeds."
  end
end
