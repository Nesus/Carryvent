class AddJobIdToPublicacionCarpools < ActiveRecord::Migration
  def change
    add_column :publicacion_carpools, :job_id, :string
  end
end
