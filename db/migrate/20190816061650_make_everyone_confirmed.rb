class MakeEveryoneConfirmed < ActiveRecord::Migration[5.2]
  def up
    User.find_each { |user| user.confirm }
  end
end
