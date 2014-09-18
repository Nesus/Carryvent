class EditPasajes < ActiveRecord::Migration
  def change
  	remove_column :pasajes , :user_evento_id
  	remove_column :pasajes , :oferta_id
  	remove_column :pasajes , :precio
  	remove_column :pasajes , :cantidad
  	remove_column :pasajes , :reserva

  	add_column :pasajes, :reserva_id , :integer
  	add_column :pasajes, :asiento, :integer
  end
end
