class AddJobIdToTransaccionCarpools < ActiveRecord::Migration
  def change
    add_column :transaccion_carpools, :job_id, :string
  end
end
