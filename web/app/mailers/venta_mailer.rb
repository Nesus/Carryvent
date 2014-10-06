class VentaMailer < ActionMailer::Base
  default from: "noreplay@carryvent.cl"

  def venta(reserva)
  	@reserva = reserva	
  	@user = reserva.user_evento.user
  	@evento = reserva.user_evento.evento
    mail(to: @user.email, subject: 'Compra de su(s) Pasaje(s)')
  end
end
