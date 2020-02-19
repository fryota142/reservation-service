class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_index :users, :name, length: 15
  end
end
