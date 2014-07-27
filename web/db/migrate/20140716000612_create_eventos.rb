class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nombre
      t.string :desc
      t.date :fecha_inicio
      t.date :fecha_termino
      t.string :imagen

      t.timestamps
    end
  end
end
