class AddLastCheckedToPublicador < ActiveRecord::Migration
  def change
    add_column :publicadors, :last_checked, :timestamp
  end
end
