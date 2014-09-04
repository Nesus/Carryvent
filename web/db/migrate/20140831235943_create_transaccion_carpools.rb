class CreateTransaccionCarpools < ActiveRecord::Migration
  def change
    create_table :transaccion_carpools do |t|
      t.references :user, index: true
      t.references :publicacion_carpool, index: true
      t.boolean :aceptado

      t.timestamps
    end
  end
end
