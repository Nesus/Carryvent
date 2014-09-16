class City < ActiveRecord::Base
	#validaciones
	validates :name , :presence => true

	#relaciones
	belongs_to :region , :class_name => 'City', :foreign_key => 'region_id'
	has_many :users
	has_many :eventos
end
