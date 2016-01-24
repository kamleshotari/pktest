class CreateParkingDetails < ActiveRecord::Migration
  def change
    create_table :parking_details do |t|
      t.integer :parking_lot_id
      t.string :reg_no
      t.string :color
      t.boolean :is_parked
      t.datetime :in_time
      t.datetime :out_time
      t.string :ticket

      t.timestamps null: false
    end
  end
end
