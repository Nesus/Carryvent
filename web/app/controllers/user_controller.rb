class UserController < ApplicationController
	#Usuarios no identificados pueden ver el index y el perfil de otros users
	before_filter :authenticate_user!, :except => [:index, :perfil]
	  
	def index
	end

	def perfil
		@user = User.find(params[:id])
		@userEventos = @user.user_eventos
	end

	def edit
    	@user = current_user
  	end

	def editar
		@user = User.find(params[:id])
	end

	
end
