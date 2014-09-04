class AddLatitudeToEvento < ActiveRecord::Migration
  def change
    add_column :eventos, :latitude, :float
  end
end
