class Ranking < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :user
	belongs_to :owner_id, :class_name => "User", :foreign_key => "user_id"
end
