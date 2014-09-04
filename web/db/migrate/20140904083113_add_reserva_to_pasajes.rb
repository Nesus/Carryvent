class AddReservaToPasajes < ActiveRecord::Migration
  def change
    add_column :pasajes, :reserva, :boolean
  end
end
