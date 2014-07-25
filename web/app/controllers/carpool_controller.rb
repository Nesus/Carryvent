class CarpoolController < ApplicationController
	
	# definir parametros
	# definir las cosas previas
	# definir los requerimientos para los 

	def publicar
		@publicacioncarpool = PublicacionCarpool.create(parametros)
		# si se falta mucho pero fui almorzar xD
	end



	def detalle
	end

	def crear_comentario
	end
end
