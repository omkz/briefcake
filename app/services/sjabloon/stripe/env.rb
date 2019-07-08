module Sjabloon
  module Stripe
    module Env
      ::Stripe.api_key             = Rails.application.credentials.dig(Rails.env.to_sym, :stripe, :private_key)
      ::StripeEvent.signing_secret = Rails.application.credentials.dig(Rails.env.to_sym, :stripe, :signing_secret)
    end
  end
end

