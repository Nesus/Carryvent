class AddFacebookPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_password, :boolean
  end
end
