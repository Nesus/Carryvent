class AddTimeToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :time, :time
  end
end
