class Pasaje < ActiveRecord::Base
	include PublicActivity::Common
  	
  	image_accessor :qr_code
  	
  	belongs_to :user_evento
  	belongs_to :oferta
  	belongs_to :bus
end
