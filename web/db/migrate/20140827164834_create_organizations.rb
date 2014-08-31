class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :contact_person
      t.string :phone
      t.boolean :valid
      t.string :facebook
      t.string :twitter

      t.timestamps
    end
  end
end
