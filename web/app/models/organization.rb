class Organization < ActiveRecord::Base
	mount_uploader :picture, ImageUploader
	has_many :eventos
end
