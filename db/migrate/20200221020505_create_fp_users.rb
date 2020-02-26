class CreateFpUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :fp_users do |t|
      t.string :name, limit: 15, null: false
      t.string :email, limit: 64, null: false
      t.string :password_digest, null: false
      t.text :introduction
      t.index :email, unique: true

      t.timestamps
    end
  end
end
