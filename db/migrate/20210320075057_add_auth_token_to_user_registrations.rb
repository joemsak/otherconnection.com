class AddAuthTokenToUserRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :user_registrations, :auth_token, :string
  end
end
