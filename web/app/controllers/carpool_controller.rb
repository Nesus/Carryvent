class CarpoolController < ApplicationController
	
	# definir parametros
	# definir las cosas previas
	# definir los requerimientos para los 

	def publicar
		@publicacioncarpool = PublicacionCarpool.new
		# si se falta mucho pero fui almorzar xD
	end

	def new
		print "Buscando userEvento"
		userEvento = UserEvento.where(["user_id = :value1 AND evento_id = :value2", {:value1 => current_user.id, :value2 => params[:evento_id]}])
		if userEvento.nil?
			print "Entró"
			userEvento = UserEvento.create!(:user_id => current_user.id , :evento_id => params[:evento_id])
		end
		#publicacionCarpool = userEvento.publicacion_carpools.new(carpool_params)
		#if publicacionCarpool.save
		#	redirect_to mostrar_carpool_path(params[:evento_id],publicacionCarpool)
		#else
			redirect_to publicar_carpool_path(params[:evento_id])
		#end
	end

	def show

	end

	def carpools
		@publicacionCarpools = PublicacionCarpool.where()
	end

	def comentarios
	end

	def detalle
	end

	def crear_comentario
	end

	private
	  def carpool_params
	    params.require(:publicacion_carpool).permit(:user_evento_id, :fecha, :descripcion, :precio, :hora_desde, :hora_hasta, :desde , :hasta)
	  end
end