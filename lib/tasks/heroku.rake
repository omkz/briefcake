# frozen_string_literal: true

namespace :heroku do
  HEROKU_APP = 'briefcake'

  desc "Copy development database to local"
  task copy: :environment do
    return "Don't run on production" if Rails.env.production?

    puts "Creating dump on heroku, takes a while"
    heroku_command('pg:backups capture')

    # check to see if its done
    until heroku_command('pg:backups info').include?("pg_dump finished successfully")
      puts "Not done yet, just a moment"
      sleep 1
    end

    system("wget -O tmp/latest.dump `heroku pg:backups public-url -q --app #{HEROKU_APP}`")

    Rake::Task['heroku:rebuild'].invoke
  end

  desc "Resume copy"
  task :resume do
    system("wget -O tmp/latest.dump -c `heroku pg:backups public-url -q --app #{HEROKU_APP}`")

    Rake::Task['heroku:rebuild'].invoke
  end

  desc "apply existing backup"
  task rebuild: :environment do
    # Update development database
    config = Rails.configuration.database_configuration["development"]
    database = config["database"]

    system("pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d #{database} #{Rails.root}/tmp/latest.dump")
  end

  private

  def heroku_command(command)
    Kernel.`("heroku #{command} --app #{HEROKU_APP}")
  end
end
