class EventoController < ApplicationController

	before_filter :authenticate_publicador!, :except => [:eventos, :show, :reservar_pasaje, :list_eventos]  

	############################
	#			USER           #
	############################

	#Mostrar todos los eventos 
	def eventos
		eventos_list = Evento.all
		@eventos= eventos_list.each_slice(6).to_a
		gustos_list = Gusto.where(user_id: current_user.id)
		eventos_de_interes = []
		gustos_list.each do |gusto|
			eventos_de_interes += Evento.where(category_id: gusto.category_id).to_a
		end
		@interes = eventos_de_interes.each_slice(3).to_a

  	end

  	#Mostramos el evento
	def show
		@evento = Evento.find(params[:id])
		@publicacionCarpools = PublicacionCarpool.joins(user_evento: [:user, :evento]).where(eventos:{id: params[:id]})
		@comments = @evento.comment_threads.order('created_at desc')
        
		#Si hay un usuario registrado creamos un comentario vacio por si quiere comentar
        if current_user
        	@pasaje = Pasaje.new
        	@new_comment = Comment.build_from(@evento, current_user.id, "")
        	#Para evitar errores mostrando pasajes
        	if current_user.user_eventos.where(:evento_id=> @evento.id).first
        		#Para que no se muestre el boton publicar carpools
        		if current_user.publicacion_carpools
        			@publicacion = true
        		else
        			@publicacion = false
        		end
        	else 
        		@publicacion = false
        	end
        end
        @hash = Gmaps4rails.build_markers(@evento) do |evento, marker|
			marker.lat evento.latitude
			marker.lng evento.longitude
			marker.infowindow evento.subtitle
			marker.json({ name: evento.name})
		end
	end

	#########################
	# 			Operario 				#
	#########################

	def list_eventos
		eventos = Evento.where("date > CURRENT_TIMESTAMP AND strftime('%m',date) = strftime('%m',CURRENT_TIMESTAMP)")
		json = {}
		json[:eventos] = []
		eventos.each do |evento|
			hash = {}
			hash[:id] = evento.id
			hash[:name] = evento.name
			hash[:date] = evento.date
			hash[:time] = evento.time
			json[:eventos].push(hash)
		end
		render :json => json.to_json
	end

	#########################
	# 		Publicador 		#
	#########################

  	#Mostrarle los eventos al publicador
  	def eventos_publicador
		@eventos = Evento.all
	end

	#Formulario creacion de eventos
	def publicar
		@evento = Evento.new
		@ciudades = City.all
		@regiones = Region.all
		@organizations = Organization.all
	end

	#Se crea el nuevo evento
	def new
		@publicador = Publicador.find(current_publicador.id)
		@evento = @publicador.eventos.create(evento_params)
		if @evento.save
			redirect_to lista_eventos_publicador_path
		else
			render 'publicar'
		end

	end

	

	def editar
		@evento = Evento.find(params[:id])
	end

	def update
		evento = Evento.find(params[:id])
		evento.update(evento_params)
		if evento.update(evento_params)
			redirect_to lista_eventos_publicador_path
		else
			render 'editar'
		end
	end


	#Tomamos solamente los parametros de evento que necesitamos
	private
	  def evento_params
	    params.require(:evento).permit(:name, :subtitle, :address, :information, :image, :date, :time)
	  end
	  def pasaje_params
	  	params.require(:pasaje).permit(:cantidad)
	  end	

end
