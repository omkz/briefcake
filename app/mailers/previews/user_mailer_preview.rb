class Previews::UserMailerPreview < ActionMailer::Preview
  def new_items
    UserMailer.new_items(User.first.id, dry_run: true)
  end

  def new_payment
    UserMailer.new_payment(User.first, { "test": "asdf", "another": "123" }, true)
  end
end
