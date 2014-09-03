class CreateGustos < ActiveRecord::Migration
  def change
    create_table :gustos do |t|
      t.references :user, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
