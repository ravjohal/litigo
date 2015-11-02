class CloseCasesForSomeUsers < ActiveRecord::Migration

  def up
    User.where(email: %w(smalley.38@gmail.com smalley38@gmail.com)).find_each { |user| user.cases.update_all(status: 'Closed') }
  end

end
