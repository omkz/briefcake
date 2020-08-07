class MoveSubscriptionFormDataToSite < ActiveRecord::Migration[5.2]
  def up
    SubscribeForm.in_batches.each do |subscribe_forms|
      subscribe_forms.each do |subscribe_form|
        if subscribe_form.url and subscribe_form.feed_url
          Site.create subscribe_form: subscribe_form, url: subscribe_form.url, feed_url: subscribe_form.feed_url
        end
      end
    end
  end

  def down
  end
end
