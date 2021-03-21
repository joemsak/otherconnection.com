class CreateUserAuthentications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_authentications, id: :uuid do |t|
      t.string :provider
      t.string :uid
      t.json :info
      t.json :credentials
      t.json :extra
      t.references :registration, type: :uuid

      t.timestamps
    end
  end
end
