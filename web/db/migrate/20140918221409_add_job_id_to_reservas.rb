class AddJobIdToReservas < ActiveRecord::Migration
  def change
    add_column :reservas, :job_id, :string
  end
end
