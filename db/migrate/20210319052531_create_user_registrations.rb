class CreateUserRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :user_registrations, id: :uuid do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
