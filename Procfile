web: bundle exec puma -C config/puma.rb
worker: bundle exec good_job start --max-threads=2 & bundle exec good_job --queues="mailers" --max-threads=1 & wait -n
release: bundle exec rake db:migrate
