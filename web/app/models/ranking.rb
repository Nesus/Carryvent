class Ranking < ActiveRecord::Base

	#Notificaciones
	include PublicActivity::Common

	#Relaciones
	belongs_to :user
	belongs_to :owner_id, :class_name => "User", :foreign_key => "user_id"
end
