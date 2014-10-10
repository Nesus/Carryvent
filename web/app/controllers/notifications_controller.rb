class NotificationsController < ApplicationController
	def index
		if current_user
			@activities = PublicActivity::Activity.where(:recipient_id => current_user.id, :recipient_type => 'User').order("created_at desc")
		elsif current_publicador
			@activities = PublicActivity::Activity.where(:recipient_id => current_publicador.id, :recipient_type => 'Publicador').order("created_at desc")
		end
			
	end

	def checking_new


	end

	def showing_recent

	end
end
