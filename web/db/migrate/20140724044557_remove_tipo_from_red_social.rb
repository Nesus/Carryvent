class RemoveTipoFromRedSocial < ActiveRecord::Migration
  def change
  	remove_column :red_socials , :tipo
  end
end
