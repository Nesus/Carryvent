class AddLongitudeToEvento < ActiveRecord::Migration
  def change
    add_column :eventos, :longitude, :float
  end
end
