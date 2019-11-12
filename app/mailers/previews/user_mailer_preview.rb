class UserMailerPreview < ActionMailer::Preview
  def new_items
    UserMailer.new_items(User.first.id, dry_run: true)
  end
end
