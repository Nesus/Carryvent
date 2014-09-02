class RemoveValidFromOrganization < ActiveRecord::Migration
  def change
  	remove_column :organizations , :valid
  end
end
