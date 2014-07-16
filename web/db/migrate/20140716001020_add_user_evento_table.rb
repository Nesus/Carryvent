class AddUserEventoTable < ActiveRecord::Migration
  def change

  	create_table :user_eventos, id: false do |t|
  		t.belongs_to :user
  		t.belongs_to :evento
  	end
  end
end
