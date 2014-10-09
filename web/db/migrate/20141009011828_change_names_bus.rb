class ChangeNamesBus < ActiveRecord::Migration
  def change
  	rename_column :buses, :lat, :latitude
  	rename_column :buses, :long, :longitude
  end
end
