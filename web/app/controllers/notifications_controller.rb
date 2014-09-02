class NotificationsController < ApplicationController
	def index
		@activities = PublicActivity::Activity.where(:owner_id => current_user.id)
		#@activities = PublicActivity::Activity.all
	end
end
