# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(Rails.application.credentials.dig(:delayed_job, :user_name), username) &&
      ActiveSupport::SecurityUtils.secure_compare(Rails.application.credentials.dig(:delayed_job, :password), password)
  end
end

run Rails.application
