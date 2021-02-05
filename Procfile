web: bundle exec puma -C config/puma.rb
worker: bin/delayed_job -n 4 start
release: bundle exec rake db:migrate
