class EventoController < ApplicationController
	before_filter :authenticate_user!, :except => [:publicar, :editar]
	before_filter :authenticate_publicador!, :except => [:eventos]  

	def eventos
    	@eventos = Evento.all
  	end

  	def eventos_publicador
		@eventos = Eventos.all
	end

	def publicar
	end

	def new
	end

	def editar
	end

end
