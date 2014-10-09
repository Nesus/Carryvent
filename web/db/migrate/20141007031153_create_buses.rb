class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.references :evento, index: true
      t.references :route, index: true
      t.integer :price
      t.integer :seats
      t.string :from
      t.integer :lat
      t.integer :long

      t.timestamps
    end
  end
end
