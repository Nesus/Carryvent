class UserController < ApplicationController

	before_filter :authenticate_user!, :except => [:index]
	  
	def index
	end

	def perfil
		@user = User.find(params[:id])
	end

end
