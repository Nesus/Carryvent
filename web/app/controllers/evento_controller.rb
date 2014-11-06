class EventoController < ApplicationController

	before_filter :authenticate_user!, :except => [:eventos, :show, :list_eventos]  
	add_breadcrumb "Inicio", :root_path
	############################
	#			USER           #
	############################

	#Mostrar todos los eventos 
	def eventos
		add_breadcrumb "Eventos", :lista_eventos_user_path

		@eventos = Evento.where("date > ? OR date = ?", Date.current, Date.current).order('date ASC')
  		#@eventos = Evento.all
  		@categorias = Category.all
  		cantidad =@categorias.length .to_i/2
  		cantidad = cantidad.ceil
  		@categorias = @categorias.each_slice(cantidad).to_a
  	end

  	#Mostramos el evento
	def show
		@evento = Evento.find(params[:id])

		add_breadcrumb "Eventos", :lista_eventos_user_path
		add_breadcrumb @evento.name, :mostrar_evento_path


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
	# 			Operario 	#
	#########################

	def list_eventos
		eventos = Evento.where("date > CURRENT_TIMESTAMP AND strftime('%m',date) = strftime('%m',CURRENT_TIMESTAMP)")
		json = {}
		json[:eventos] = []
		eventos.each do |evento|
			hash = {}
			hash[:id] = evento.id
			hash[:name] = evento.name
			hash[:date] = evento.date.strftime("%d/%m/%Y")
			hash[:time] = evento.time.strftime("%H:%M")
			hash[:address] = evento.address
			hash[:image] = evento.image.small.url
			json[:eventos].push(hash)
		end
		render :json => json.to_json
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
