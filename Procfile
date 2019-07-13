web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -q rssmailer_production_default -q rssmailer_production_mailers
cron: sleep infinity
