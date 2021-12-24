web: bundle exec puma -C config/puma.rb
worker: bundle exec good_job start --max-threads=5 & bundle exec good_job --queues="high" --max-threads=2 & bundle exec good_job --queues="low" --max-threads=3 & wait -n
release: bundle exec rake db:migrate
