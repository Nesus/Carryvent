class CreatePublicacionCarpools < ActiveRecord::Migration
  def change
    create_table :publicacion_carpools do |t|
      t.belongs_to :user_evento
      t.date :fecha
      t.text :descripcion
      t.integer :precio
      t.time :hora_desde
      t.string :desde
      t.time :hora_hasta
      t.time :hasta

      t.timestamps
    end
  end
end
