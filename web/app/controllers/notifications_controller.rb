class NotificationsController < ApplicationController
	def index
		@activities = PublicActivity::Activity.where(:recipient_id => current_user.id).order("created_at desc")
	end
end
