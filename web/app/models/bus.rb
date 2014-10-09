class Bus < ActiveRecord::Base
	validates :evento_id, presence: true
	validates :route_id, presence: true
	validates :price, numericality: true
	validates :seats, numericality: true
	
	belongs_to :evento
	belongs_to :route


	#geocoded
	geocoded_by :from
	before_create :geocode
end
