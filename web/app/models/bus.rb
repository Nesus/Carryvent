class Bus < ActiveRecord::Base
	belongs_to :evento
	belongs_to :route
end
