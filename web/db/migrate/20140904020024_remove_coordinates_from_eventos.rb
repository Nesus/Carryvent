class RemoveCoordinatesFromEventos < ActiveRecord::Migration
  def change
  	remove_column :eventos, :coordinates
  end
end
