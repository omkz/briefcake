namespace :daily do
    task cleanup_bots: :environment do
        BotsCleanupJob.perform_later
    end
end
