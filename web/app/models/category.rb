class Category < ActiveRecord::Base
	#Relaciones
	has_many :gustos
	has_many :users, through: :gustos
	has_many :eventos
end
