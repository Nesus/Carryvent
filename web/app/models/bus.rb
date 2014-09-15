class Bus < ActiveRecord::Base
	belongs_to :evento
	has_many :pasajes
end
