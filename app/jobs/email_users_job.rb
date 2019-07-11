class EmailUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each { |user| UserMailer.new_items(user).deliver }
  end
end
