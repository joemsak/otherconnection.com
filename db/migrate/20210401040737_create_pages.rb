class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages, id: :uuid do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end
  end
end
