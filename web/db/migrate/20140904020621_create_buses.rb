class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.integer :bus_id
      t.string :patente
      t.integer :empresa_id
      t.string :patente
      t.integer :asientos
      t.string :tipo

      t.timestamps
    end
  end
end
