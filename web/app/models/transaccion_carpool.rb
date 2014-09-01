class TransaccionCarpool < ActiveRecord::Base
	
  belongs_to :user
  belongs_to :publicacion_carpool
end
