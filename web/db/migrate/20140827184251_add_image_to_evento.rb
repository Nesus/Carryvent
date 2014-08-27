class AddImageToEvento < ActiveRecord::Migration
  def change
	add_column :eventos, :image, :string
  end
end
