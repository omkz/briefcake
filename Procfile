web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -q rssmailer_development_default -q rssmailer_development_mailers
cron: sleep infinity
