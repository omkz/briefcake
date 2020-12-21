class PaddleController < ApplicationController
  skip_before_action :verify_authenticity_token

  def hook
    data = params.to_unsafe_h

    public_key = Rails.application.credentials.paddle_private_key

    signature = Base64.decode64(data["p_signature"])

    # Remove the p_signature parameter
    data.delete("p_signature")
    data.delete("controller")
    data.delete("action")

    # Ensure all the data fields are strings
    data.each { |key, value| data[key] = value.to_s }

    # Sort the data
    data_sorted = data.sort_by { |key, _| key }

    # and serialize the fields
    # serialization library is available here: https://github.com/jqr/php-serialize
    data_serialized = PHP.serialize(data_sorted, true)

    # verify the data
    digest = OpenSSL::Digest::SHA1.new
    pub_key = OpenSSL::PKey::RSA.new(public_key).public_key
    verified = pub_key.verify(digest, signature, data_serialized)

    if !verified
      Honeybadger.notify("Signature does not match", { signature: signature, data_sorted: data_sorted })
      # return head 422
    end

    user = User.find_by(id: data["passthrough"])
    made_profit = data["alert_name"] === "subscription_payment_succeeded"

    if user
      is_subscribed = data["status"] === "active"

      user.update!({
                     is_pro: is_subscribed,
                     paddle_user_id: data["user_id"],
                     paddle_subscription_id: data["subscription_id"],
                     paddle_email: data["email"]
                   })

      if made_profit
        Profit.create(amount: data["balance_earnings"].to_f, data: data)
      end
    end

    if made_profit
      UserMailer.new_payment(user, data_sorted, verified).deliver_later
    end

    render json: :ok
  end
end
