class AddLastCheckedToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_checked, :timestamp
  end
end
