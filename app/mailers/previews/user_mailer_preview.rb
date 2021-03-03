class Previews::UserMailerPreview < ActionMailer::Preview
  def newsletter
    UserMailer.newsletter(User.first.id, dry_run: true)
  end
end
