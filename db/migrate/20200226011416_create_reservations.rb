class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :fp_user, foreign_key: true, null: false
      t.references :user, foreign_key: true
      t.date :date, null: false
      t.time :start_time, null: false
      t.boolean :reserved, default: false, null: false

      t.timestamps
    end
  end
end
