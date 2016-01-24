class CreateParkingLots < ActiveRecord::Migration
  def change
    create_table :parking_lots do |t|
      t.integer :floor_level
      t.integer :slot_no
      t.float :distance
      t.boolean :is_allocated

      t.timestamps null: false
    end
  end
end
