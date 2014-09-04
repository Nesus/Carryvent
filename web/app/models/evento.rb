class Evento < ActiveRecord::Base

	#Subir imagenes
	mount_uploader :image, ImageUploader

	#Comentarios
	acts_as_commentable

	#Relaciones
	## Un evento tiene varios usuarios que asisten a el
	has_many :user_eventos
	has_many :users , through: :user_eventos
	has_many :publicacion_carpool, through: :user_eventos
	has_many :pasajes, through: :user_eventos
	has_many :buses
	
	#Pertenece al publicador que lo publico
	belongs_to :publicador
	belongs_to :city
	belongs_to :region
	belongs_to :organization
	belongs_to :category



	#Validaciones
	validates :name, presence: true
	validates :subtitle, presence: true
	validates :publicador_id, presence: true

	#geocoded
	geocoded_by :address
	after_validation :geocode



end
