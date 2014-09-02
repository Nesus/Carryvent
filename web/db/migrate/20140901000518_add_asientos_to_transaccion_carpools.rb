class AddAsientosToTransaccionCarpools < ActiveRecord::Migration
  def change
    add_column :transaccion_carpools, :asientos, :integer
  end
end
