class AddUserData < ActiveRecord::Migration
  def change
  		add_column :users, :nombre, :string
  		add_column :users, :ciudad, :string
  		add_column :users, :region, :string
  		add_column :users, :telefono, :string
  		add_column :users, :cumple, :date
  		add_column :users, :rut, :string
  		add_column :users, :dv, :string
  		add_column :users, :direccion, :text
  end
end
