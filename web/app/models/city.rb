class City < ActiveRecord::Base
	#validaciones
	validates :name , :presence => true

	#relaciones
	belongs_to :region
	has_many :users
	has_many :eventos
end
