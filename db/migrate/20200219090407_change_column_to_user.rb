class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_index :users, :email, unique: true
    change_column :users, :name, :string, limit: 15
  end
end
