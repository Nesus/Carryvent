class ChangeLatLongToFloat < ActiveRecord::Migration
  def change
  	change_column :buses, :latitude, :float
  	change_column :buses, :longitude, :float
  end
end
