class AddTimeToBus < ActiveRecord::Migration
  def change
    add_column :buses, :time, :time
  end
end
