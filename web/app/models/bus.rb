class Bus < ActiveRecord::Base
	belongs_to :evento
	belongs_to :route

	#geocoded
	geocoded_by :from
	after_validation :geocode

  
end
