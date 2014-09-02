class Region < ActiveRecord::Base
	has_many :cities
	has_many :users
	has_many :eventos
end
