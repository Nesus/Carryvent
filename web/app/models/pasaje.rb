class Pasaje < ActiveRecord::Base
	#Notificaciones
	include PublicActivity::Common

	#Validaciones
	validates :precio, presence: true
	validates :codigo, presence: true
	validates :reserva, presence: true

	#Relaciones
  	belongs_to :user_evento
 	belongs_to :oferta
  	belongs_to :bus
end
