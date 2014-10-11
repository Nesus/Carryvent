class NotificationsController < ApplicationController
	def index
		current_user.update(:last_checked => DateTime.now)
		last_notifications
		if current_user
			@activities = PublicActivity::Activity.where(:recipient_id => current_user.id, :recipient_type => 'User').order("created_at desc").limit(10)
		elsif current_publicador
			@activities = PublicActivity::Activity.where(:recipient_id => current_publicador.id, :recipient_type => 'Publicador').order("created_at desc").limit(10)
		end
			
	end

	def checking_new
		if current_user
			last = current_user.last_checked
			@activities = PublicActivity::Activity.where(:recipient_id => current_user.id, :recipient_type => 'User').where("created_at > ?", last ).count()
		elsif current_publicador
			@activities = PublicActivity::Activity.where(:recipient_id => current_publicador.id, :recipient_type => 'Publicador').count()
		end
	end

	def showing_recent
		if current_user
			@activities = PublicActivity::Activity.where(:recipient_id => current_user.id, :recipient_type => 'User').order("created_at desc").limit(10)
		elsif current_publicador
			@activities = PublicActivity::Activity.where(:recipient_id => current_publicador.id, :recipient_type => 'Publicador').order("created_at desc").limit(10)
		end
	end
end
