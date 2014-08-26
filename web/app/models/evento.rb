class Evento < ActiveRecord::Base
	#Relaciones
	## Un evento tiene varios usuarios que asisten a el
	has_many :user_eventos
	has_many :users , through: :user_eventos

	#Pertenece al publicador que lo publico
	belongs_to :publicador


	#Validaciones
	validates :nombre, presence: true
	validates :desc, presence: true
	validates :publicador_id, presence: true
end
