class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.text :points
      t.references :city, index: true
      t.references :region, index: true
      t.string :comment

      t.timestamps
    end
  end
end
