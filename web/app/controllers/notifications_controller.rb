class NotificationsController < ApplicationController
	def index
		@notifications = PublicActivity:Activity.all
		#@activities = PublicActivity::Activity.all
	end
end
