class ChangeEventTable < ActiveRecord::Migration
  def change
	#Quitando todos los atributos antiguos
	remove_column :eventos, :desc
	remove_column :eventos, :nombre
	remove_column :eventos, :fecha_inicio
	remove_column :eventos, :fecha_termino
	remove_column :eventos, :imagen

	#Agregando nuevos atributos
	add_column :eventos, :name, :string
	add_column :eventos, :subtitle, :string
	add_column :eventos, :address, :string
	add_column :eventos, :information, :string
	add_column :eventos, :coordinates, :string
	
	#Agregando relaciones
	add_column :eventos, :organization_id, :integer
	add_column :eventos, :category_id, :integer
	add_column :eventos, :city_id, :integer
	add_column :eventos, :region_id, :integer
  end
end
