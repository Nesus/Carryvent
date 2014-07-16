class CreateRedSocials < ActiveRecord::Migration
  def change
    create_table :red_socials do |t|
      t.integer :tipo
      t.references :user, index: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
