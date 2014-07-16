class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nombre
      t.string :desc
      t.date :fechaInicio
      t.date :fechaTermino
      t.string :imagen

      t.timestamps
    end
  end
end
