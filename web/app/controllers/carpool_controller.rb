class CarpoolController < ApplicationController
	
	# definir parametros
	# definir las cosas previas
	# definir los requerimientos para los 

	def publicar
		@publicacioncarpool = PublicacionCarpool.new
		# si se falta mucho pero fui almorzar xD
	end

	def new
		userEvento = current_user.user_eventos.new(:evento_id => params[:evento_id])
		if userEvento.save
		
		#falta limitar 1 publicacion por usuario
			publicacionCarpool = PublicacionCarpool.new(carpool_params.merge(:user_evento_id => userEvento.id))
			if publicacionCarpool.save
				redirect_to mostrar_carpool_path(params[:evento_id],publicacionCarpool)
			else
				redirect_to publicar_carpool_path(params[:evento_id])
			end
		else
			print userEvento.errors.full_messages
		end
	end

	def show
		@carpool = PublicacionCarpool.find(params[:id])
        @comments = @carpool.comment_threads.order('created_at desc')
        @new_comment = Comment.build_from(@carpool, current_user.id, "")
    end

	private
	  def carpool_params
	    params.require(:publicacion_carpool).permit(:user_evento_id, :fecha, :descripcion, :precio, :hora_desde, :hora_hasta, :desde , :hasta)
	  end
end