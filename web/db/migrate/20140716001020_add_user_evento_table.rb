class AddUserEventoTable < ActiveRecord::Migration
  def change
  	create_table :user_eventos do |t|
  		t.belongs_to :user
  		t.belongs_to :evento
  		
  		t.timestamps
  	end
  end
end
