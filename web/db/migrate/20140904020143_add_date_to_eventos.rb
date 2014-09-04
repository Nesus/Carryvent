class AddDateToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :date, :date
  end
end
