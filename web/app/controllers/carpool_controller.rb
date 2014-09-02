class CarpoolController < ApplicationController

	before_filter :authenticate_user!, :except => [:show]

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
				userEvento.destroy
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
        asientosTomados = @carpool.transaccion_carpools.where(:aceptado => true).count
        @asientosDisp = @carpool.asientos_disp - asientosTomados
        @comments = @carpool.comment_threads.order('created_at desc')
        @new_comment = Comment.build_from(@carpool, current_user.id, "")

        @transaccion = TransaccionCarpool.new
    end

   	def new_transaction
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])
   		#Usuario que pide el carpool
   		user = current_user
   		#Usuario que publico el carpool
   		userPub = User.joins(user_eventos: [:user, :evento, :publicacion_carpool]).where(publicacion_carpools: {id: params[:id]}).first
   		if user != userPub
   			trans = user.transaccion_carpools.new(:asientos => trans_carpool_params["asientos"],  :publicacion_carpool_id => carpool.id , :aceptado => false )

   			if trans.save
   				#Active Record
   				trans.create_activity :create, owner: current_user, recipient: carpool.user_evento.user, parameters: {asientos: trans_carpool_params["asientos"] , publicacion_carpool_id: carpool.id  }
   				##MOSTRAR QUE SE PUDO CREAR
   				redirect_to mostrar_carpool_path(evento, carpool)
   			else
   				#MOSTRAR ERROR QUE NO SE PUDO CREAR
   				redirect_to mostrar_carpool_path(evento, carpool)
   			end
   		end
   	end


    #Tomamos solamente los parametros que sirven para publicacion_carpool
	private
	  def carpool_params
	    params.require(:publicacion_carpool).permit(:user_evento_id, :fecha, :descripcion, :precio, :hora_desde, :hora_hasta, :desde , :hasta)
	  end

	  def trans_carpool_params
	  	params.require(:transaccion_carpool).permit(:asientos)
	  end
end