class AddUsernameToPublicador < ActiveRecord::Migration
  def change
    add_column :publicadors, :username, :string
    add_index :publicadors, :username, unique: true
  end
end
