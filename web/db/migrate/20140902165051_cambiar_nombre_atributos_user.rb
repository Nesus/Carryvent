class CambiarNombreAtributosUser < ActiveRecord::Migration
  def change
  	rename_column :users, :ciudad_id, :city_id
  end
end
