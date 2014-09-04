class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :value
      t.text :comment
      t.boolean :assist
      t.boolean :driver
      t.references :user, index: true
      t.integer :owner_id

      t.timestamps
    end
  end
end
