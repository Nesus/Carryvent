class AddPointToReserva < ActiveRecord::Migration
  def change
    add_column :reservas, :point, :text
  end
end
