class CambiarCamposAUser < ActiveRecord::Migration
  def change
  	remove_column :users, :ciudad
  	remove_column :users, :region

  	remove_column :users, :telefono
  	remove_column :users, :cumple
  	remove_column :users , :rut
  	remove_column :users, :dv

  	add_column :users, :ciudad_id , :integer
  	add_column :users, :region_id , :integer
  	add_column :users, :ranking, :float
  	
  end
end
