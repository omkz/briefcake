class BotsCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    bots = 0
    humans = 0
    total = 0
    User.includes(:feeds).in_batches do |batch|
      batch.each do |user|
        if user.is_suspected_bot?
          puts "#{user.email} is probably a bot!"
          bots += 1
        else
          puts "#{user.email} is probably not a bot!"
          humans += 1
        end
        total += 1
      end
    end
    puts "#{bots} bots, #{humans} humans found out of #{total} users."
  end
end
