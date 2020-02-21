class CreateFpusers < ActiveRecord::Migration[5.2]
  def change
    create_table :fpusers do |t|
      t.string :name, limit: 15
      t.string :email, limit: 64
      t.string :password_digest
      t.text :introduction
      t.index :email, unique: true

      t.timestamps
    end
  end
end
