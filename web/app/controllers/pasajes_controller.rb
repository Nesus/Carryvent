class PasajesController < ApplicationController
	def reserva
		@evento = Evento.find(params[:id])
		@reserva = Reserva.new
	end

	def reserva_send
		evento = Evento.find(params[:id])
		user_evento = current_user.user_eventos.new(:evento_id => evento.id)
		state = 0
		asientos = params["reserva"]["asientos"]

		if user_evento.save
			reserva = Reserva.new(:user_evento_id => user_evento.id,:amount =>reserva_params["amount"], :state => state)
			
			if reserva.save
				asientos.each do |i|
					asiento = Pasaje.new(:reserva_id => reserva.id , :asiento => i.to_i)
					if asiento.save == false
						return 	redirect_to reserva_pasaje_path(evento)
					end
				end

				#Creamos las notificaciones
				reserva.create_activity :reserva, owner: current_user, recipient: evento.publicador, parameters: {cantidad: reserva.amount}
				reserva.create_activity :notificacion, owner: evento.publicador, recipient: current_user


				#Enviamos emails
				ReservaMailer.reserva(current_user, evento, reserva).deliver

				return redirect_to pasaje_reservado_path(evento)
			else
				return redirect_to reserva_pasaje_path(evento)
			end
		else
			return redirect_to reserva_pasaje_path(evento)
		end
	end

	def reservado

	end

	def aceptar_reserva
		#Cambiamos el estado de la reserva a 1
		reserva = Reserva.find(params[:id])
		reserva.update(:state => 1)

		##Enviar emails

		##Enviar notificaciones
	end

	private

	def reserva_params
		params.require(:reserva).permit(:amount)
	end

=begin
	def reservar_pasaje
		evento = Evento.find(params[:id])
		user_evento = current_user.user_eventos.new(:evento_id => evento.id)
		pasaje = user_evento.pasajes.new(pasaje_params.merge(:precio => 10000))
		if pasaje.save
			#Se crean las notificaciones a los distintos participantes
			pasaje.create_activity :reserva, owner: current_user, recipient: evento.publicador, parameters: {cantidad: pasaje.cantidad}
			pasaje.create_activity :notificacion, owner: evento.publicador, recipient: current_user
			redirect_to notifications_path
		else 
			##CAMBIAR ESTO
			redirect_to root_path
	end
=end


end
