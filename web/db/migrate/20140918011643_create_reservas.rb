class CreateReservas < ActiveRecord::Migration
  def change
    create_table :reservas do |t|
      t.string :code
      t.integer :amount
      t.references :user_evento, index: true
      t.integer :state
      t.datetime :ttl

      t.timestamps
    end
  end
end
