class CreateOferta < ActiveRecord::Migration
  def change
    create_table :oferta do |t|
      t.string :nombre
      t.string :desc
      t.integer :porcentaje
      t.boolean :cantidad

      t.timestamps
    end
  end
end
