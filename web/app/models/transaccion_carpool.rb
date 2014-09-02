class TransaccionCarpool < ActiveRecord::Base
	include PublicActivity::Common
	
	#Relaciones
	belongs_to :user
	belongs_to :publicacion_carpool
end
