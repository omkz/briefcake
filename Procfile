web: bundle exec puma -C config/puma.rb
worker: bundle exec good_job start --max-threads=1 & bundle exec good_job --queues="low" --max-threads=2 & wait -n
release: bundle exec rake db:migrate
