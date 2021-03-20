class AddSessionTokenToUserRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :user_registrations, :session_token, :string
  end
end
