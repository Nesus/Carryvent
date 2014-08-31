class AddColumnsToPublicacionCarpools < ActiveRecord::Migration
  def change
  	#Quitamos columnas que no se usarán
  	remove_column :publicacion_carpools , :precio
  	remove_column :publicacion_carpools , :hora_hasta
  	remove_column :publicacion_carpools , :hasta

  	#Agregamos columnas necesarias
  	add_column :publicacion_carpools, :asientos_disp , :integer
  	add_column :publicacion_carpools, :tipo_vehiculo , :string
  	add_column :publicacion_carpools, :celular, :string
  end
end
