class AddPublicadorRefToEvento < ActiveRecord::Migration
  def change
    add_reference :eventos, :publicador, index: true
  end
end
