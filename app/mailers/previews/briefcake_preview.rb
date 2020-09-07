# Preview all emails at http://localhost:3000/rails/mailers/briefcake
class BriefcakePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/briefcake/transition_email
  def transition_email
    BriefcakeMailer.with(user: User.first).transition_email
  end

end
