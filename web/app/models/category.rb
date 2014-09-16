class Category < ActiveRecord::Base

	#validaciones
	validates :name, :presence => true

	#Relaciones
	has_many :gustos
	has_many :users, through: :gustos
	has_many :eventos
end
