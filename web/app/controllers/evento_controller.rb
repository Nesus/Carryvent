class EventoController < ApplicationController

	before_filter :authenticate_publicador!, :except => [:eventos, :show]  

	def eventos
		@eventos = Evento.all
  	end

  	def eventos_publicador
		@eventos = Evento.all
	end

	def publicar
		@evento = Evento.new
	end

	def new
		@publicador = Publicador.find(current_publicador.id)
		@evento = @publicador.eventos.create(evento_params)
		if @evento.save
			redirect_to lista_eventos_publicador_path
		else
			render 'publicar'
		end

	end

	def show
		@evento = Evento.find(params[:id])
		@publicacionCarpools = PublicacionCarpool.joins(user_evento: [:user, :evento]).where(eventos:{id: params[:id]})
		@comments = @evento.comment_threads.order('created_at desc')
        if current_user
        	@new_comment = Comment.build_from(@evento, current_user.id, "")
        end
	end


	def editar
		@evento = Evento.find(params[:id])
	end


	#Tomamos solamente los parametros de evento que necesitamos
	private
	  def evento_params
	    params.require(:evento).permit(:name, :subtitle, :address, :information, :coordinates, :image)
	  end
end
