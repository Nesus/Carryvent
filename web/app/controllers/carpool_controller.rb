class CarpoolController < ApplicationController

  #Restringiendo usuarios no conectados solo a ver carpool
	before_filter :authenticate_user!, :except => [:show]

  #######################
  # Publicar y mostrar  #
  #######################

	#Vista de publicar carpool
	def publicar
		@publicacioncarpool = PublicacionCarpool.new
	end

	#Crear una nueva publicacion de carpool
	def new
		#Generamos user_evento y lo guardamos
		userEvento = current_user.user_eventos.new(:evento_id => params[:evento_id])
		
    #Se guarda el user_evento
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
      redirect_to publicar_carpool_path(params[:evneto_id])
		end
	end

  #Editar carpool
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

    if @userPub != current_user
      @transUser = @carpool.transaccion_carpools.where(:user_id => current_user.id).first
    else
      @peticiones = @carpool.transaccion_carpools
    end

    @transaccion = TransaccionCarpool.new
  end

  ########################
  #     Transacciones    # 
  ########################


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
      else
        redirect_to mostrar_carpool_path(evento,carpool)
   		end
   	end

    #Aceptar peticion
   	def aceptar_transaction

   		transaccion = TransaccionCarpool.find(params[:transaction_id])
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])
   		
      #Se cambia el valor de la transaccion a aceptado
      # y se crea la respectiva notificacion
      aceptar = transaccion.update(:aceptado => true)
   		transaccion.create_activity :aceptado, owner:current_user , recipient:transaccion.user , parameters: {asientos: transaccion.asientos , publicacion_carpool_id: carpool.id  }
   	  
      #Creamos la encuesta que será "enviada" despues de la hora y fecha del carpool
      scheduler = Rufus::Scheduler.new
    
      if carpool.date_time < DateTime.current
        fecha = DateTime.current + 1.minutes
      else 
        fecha = carpool.date_time
      end
        job_id = scheduler.in fecha.to_s do
        #Creamos las encuestas
        encuestaUser = Ranking.new(driver: false, user_id:carpool.user_evento.user , owner_id:transaccion.user)
        encuestaPub = Ranking.new(driver: true, user_id: current_user, owner_id: carpool.user_evento.user)
        encuestaUser.save
        encuestaPub.save
        #Creamos las notificaciones
        encuestaUser.create_activity :created, owner: transaccion.user, recipient: carpool.user_evento.user
        encuestaPub.create_activity :created, owner: carpool.user_evento.user,  recipient: transaccion.user
       end
       #Guardamos la id del scheduler
       transaccion.update(:job_id => job_id)

      redirect_to mostrar_carpool_path(evento,carpool)
    end

    #Rechazar peticion
   	def rechazar_transaction
   		transaccion = TransaccionCarpool.find(params[:transaction_id])
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])

      #Cambiamos el estado de la transaccion a rechazado y
      # se crea una notificacion diciendo que se rechazo
   		rechazar = transaccion.update(:aceptado => false)
   		transaccion.create_activity :rechazado, owner:current_user , recipient:transaccion.user, parameters: {asientos:transaccion.asientos , publicacion_carpool_id: carpool.id  }
   	  
      #Buscamos si existe un trabajo relacionado a la transaccion
      scheduler = Rufus::Scheduler.new
      job = scheduler.job(transaccion.job_id)
      if job
        job.unschedule
      end 
      redirect_to mostrar_carpool_path(evento,carpool)
    end

    #Borrar transaccion
   	def delete_transaction
		  transaccion = TransaccionCarpool.find(params[:transaction_id])
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])

      #Se borra la transaccion
   		borrar = transaccion.destroy
   		transaccion.create_activity :borrado, owner:current_user , recipient:transaccion.user, parameters: {asientos: transaccion.asientos , publicacion_carpool_id: carpool.id  }
   	  
      redirect_to mostrar_carpool_path(evento,carpool)
    end

    #Editar asientos de peticion
   	def cambiar_asientos
   		transaccion = TransaccionCarpool.find(params[:transaction_id])
   		evento = Evento.find(params[:evento_id])
   		carpool = PublicacionCarpool.find(params[:id])
      
      #Vemos si el usuario que mando la peticion es el mismo que la creo
      if current_user == transaccion.user.id
   		 cambiar = transaccion.update(:asientos => params[:asientos])
   		 transaccion.create_activity :updated, owner: current_user, recipient: carpool.user_evento.user, parameters: {asientos: trans_carpool_params["asientos"] , publicacion_carpool_id: carpool.id  }
   	  end
    end

    #Tomamos solamente los parametros que sirven para publicacion_carpool
	private
	  def carpool_params
	    params.require(:publicacion_carpool).permit(:user_evento_id, :fecha, :descripcion, :hora_desde, :desde , :asientos_disp, :tipo_vehiculo, :celular)
	  end

	  def trans_carpool_params
	  	params.require(:transaccion_carpool).permit(:asientos)
	  end
end