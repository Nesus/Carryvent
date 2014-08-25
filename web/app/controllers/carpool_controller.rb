class CarpoolController < ApplicationController
	before_filter :authenticate_user!

	# definir parametros
	# definir las cosas previas
	# definir los requerimientos para los 

	#Vista de publicar carpool
	def publicar
		@publicacioncarpool = PublicacionCarpool.new
	end

	#Crear una nueva publicacion de carpool
	def new
		#Generamos user_evento y lo guardamos
		userEvento = current_user.user_eventos.new(:evento_id => params[:evento_id])
		
		if userEvento.save
		#falta limitar 1 publicacion por usuario
			publicacionCarpool = PublicacionCarpool.new(carpool_params.merge(:user_evento_id => userEvento.id))
			
			#Vemos si se guardo correctamente
			if publicacionCarpool.save
				redirect_to mostrar_carpool_path(params[:evento_id],publicacionCarpool)
			else
				redirect_to publicar_carpool_path(params[:evento_id])
			end
		else
			print userEvento.errors.full_messages
		end
	end

	#Mostramos todo lo relevante a la publicacion carpool
	def show
		@evento = Evento.find(params[:evento_id])
		@carpool = PublicacionCarpool.find(params[:id])
		@userPub = User.joins(user_eventos: [:user, :evento, :publicacion_carpool]).where(publicacion_carpools: {id: params[:id]}).first
        @comments = @carpool.comment_threads.order('created_at desc')
        @new_comment = Comment.build_from(@carpool, current_user.id, "")
    end

    #Tomamos solamente los parametros que sirven para publicacion_carpool
	private
	  def carpool_params
	    params.require(:publicacion_carpool).permit(:user_evento_id, :fecha, :descripcion, :precio, :hora_desde, :hora_hasta, :desde , :hasta)
	  end
end