class City < ActiveRecord::Base
	belongs_to :region , :class_name => 'City', :foreign_key => 'region_id'
	has_many :users
	has_many :eventos
end
