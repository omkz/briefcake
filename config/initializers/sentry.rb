Raven.configure do |config|
  config.dsn = Rails.application.credentials.dig(:production, :sentry, :dsn)
  config.environments = ["production"]
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
