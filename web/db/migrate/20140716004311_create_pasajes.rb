class CreatePasajes < ActiveRecord::Migration
  def change
    create_table :pasajes do |t|
      t.references :user_evento, index: true
      t.references :oferta, index: true
      t.integer :precio
      t.integer :cantidad
      t.string :codigo

      t.timestamps
    end
  end
end
