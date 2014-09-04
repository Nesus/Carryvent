class EventoController < ApplicationController

	before_filter :authenticate_publicador!, :except => [:eventos, :show, :reservar_pasaje]  

	############################
	#			USER           #
	############################

	#Mostrar todos los eventos 
	def eventos
		eventos_list = Evento.all
		@eventos= eventos_list.each_slice(6).to_a

  	end

  	#Mostramos el evento
	def show
		@evento = Evento.find(params[:id])
		@publicacionCarpools = PublicacionCarpool.joins(user_evento: [:user, :evento]).where(eventos:{id: params[:id]})
		@comments = @evento.comment_threads.order('created_at desc')
        if current_user
        	@pasaje = Pasaje.new
        	@new_comment = Comment.build_from(@evento, current_user.id, "")
        	@reservas = current_user.user_eventos.where(:evento_id=> @evento.id).first.pasajes
        end
        @hash = Gmaps4rails.build_markers(@evento) do |evento, marker|
			marker.lat evento.latitude
			marker.lng evento.longitude
			marker.infowindow evento.subtitle
			marker.json({ name: evento.name})
		end
	end


	def reservar_pasaje
		evento = Evento.find(params[:id])
		user_evento = current_user.user_eventos.new(:evento_id => evento.id)
		pasaje = user_evento.pasajes.new(pasaje_params.merge(:precio => 10000))
		if pasaje.save
			pasaje.create_activity :reserva, owner: current_user, recipient: evento.publicador, parameters: {cantidad: pasaje.cantidad}
			pasaje.create_activity :notificacion, owner: evento.publicador, recipient: current_user
			redirect_to notifications_path
		else 
			##CAMBIAR ESTO
			redirect_to root_path
		end

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
