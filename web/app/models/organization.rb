class Organization < ActiveRecord::Base
	#Validaciones
	validates :name, presence: true
	validates :contact_person, presence: true
	validates :phone, presence: true

	#Relaciones
	mount_uploader :picture, ImageUploader
	has_many :eventos
end
