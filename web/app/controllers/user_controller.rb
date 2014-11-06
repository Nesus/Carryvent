class UserController < ApplicationController
	#Usuarios no identificados pueden ver el index y el perfil de otros users
	before_filter :authenticate_user!, :except => [:index, :perfil]
	  
	def index
		eventos_de_interes = []
		current_user.gustos.each do |gusto|
			eventos_de_interes += gusto.category.eventos.to_a
		end
		@interes = eventos_de_interes.each_slice(3).to_a
	end

	def perfil
		@user = User.find(params[:id])
		
		@userEventosAceptados = @user.reservas.aceptado
		@userCarpools = @user.publicacion_carpools
		#u.reservas.aceptado.first.user_evento.evento.name
		gustoUser = Gusto.where(user_id: @user.id)
		@gustos = []
		gustoUser.each do |gu|
			@gustos.push(Category.find(gu.category_id).name)
		end







	end

	def edit
    	@user = current_user
  	end

	def editar
		@user = User.find(params[:id])
	end



	
end
