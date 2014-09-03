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

  #Editar evento
	def update
		publicacionCarpool = PublicacionCarpool.find(params[:id])
		publicacionCarpool.update(carpool_params)
	end

	#Mostramos todo lo relevante a la publicacion carpool
	def show
		@evento = Evento.find(params[:evento_id])
		@carpool = PublicacionCarpool.find(params[:id])
		@userPub = User.joins(user_eventos: [:user, :evento, :publicacion_carpool]).where(publicacion_carpools: {id: params[:id]}).first
    
    #Contando asientos libres
    asientosTomados = @carpool.transaccion_carpools.where(:aceptado => true).count
    @asientosDisp = @carpool.asientos_disp - asientosTomados
    
    #Comentarios
    @comments = @carpool.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@carpool, current_user.id, "")

    @transaccion = TransaccionCarpool.new
    end

    #Creando nueva peticion
   	def new_transaction
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])
   		#Usuario que pide el carpool
   		user = current_user
   		#Usuario que publico el carpool
   		userPub = User.joins(user_eventos: [:user, :evento, :publicacion_carpool]).where(publicacion_carpools: {id: params[:id]}).first
   		if user != userPub

   			trans = user.transaccion_carpools.new(:asientos => trans_carpool_params["asientos"],  :publicacion_carpool_id => carpool.id , :aceptado => nil)

   			if trans.save
   				#Se crea la notificacion
   				trans.create_activity :create, owner: current_user, recipient: carpool.user_evento.user, parameters: {asientos: trans_carpool_params["asientos"] , publicacion_carpool_id: carpool.id  }
   				##MOSTRAR QUE SE PUDO CREAR
   				redirect_to mostrar_carpool_path(evento, carpool)
   			else
   				#MOSTRAR ERROR QUE NO SE PUDO CREAR
   				redirect_to mostrar_carpool_path(evento, carpool)
   			end
   		end
   	end

    #Aceptar peticion
   	def aceptar_transaction
   		transaccion = TransaccionCarpool.find(params[:transaction_id])
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])
   		aceptar = transaccion.update(:aceptado => true)
   		transaccion.create_activity :aceptado, owner: current_user, recipient: carpool.user_evento.user, parameters: {asientos: trans_carpool_params["asientos"] , publicacion_carpool_id: carpool.id  }
   	end

    #Rechazar peticion
   	def rechazar_transaction
   		transaccion = TransaccionCarpool.find(params[:transaction_id])
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])
   		rechazar = transaccion.update(:aceptado => false)
   		transaccion.create_activity :rechazado, owner: current_user, recipient: carpool.user_evento.user, parameters: {asientos: trans_carpool_params["asientos"] , publicacion_carpool_id: carpool.id  }
   	end

    #Borrar transaccion
   	def delete_transaction
		  transaccion = TransaccionCarpool.find(params[:transaction_id])
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])
   		borrar = transaccion.destroy
   		transaccion.create_activity :borrado, owner: current_user, recipient: carpool.user_evento.user, parameters: {asientos: trans_carpool_params["asientos"] , publicacion_carpool_id: carpool.id  }
   	end

    #Editar asientos de peticion
   	def cambiar_asientos
   		transaccion = TransaccionCarpool.find(params[:transaction_id])
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])
      
      #Vemos si el usuario que mando la peticion es el mismo que la creo
      if current_user == transaccion.user.id
   		 cambiar = transaccion.update(:asientos => params[:asientos])
   		 transaccion.create_activity :borrado, owner: current_user, recipient: carpool.user_evento.user, parameters: {asientos: trans_carpool_params["asientos"] , publicacion_carpool_id: carpool.id  }
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