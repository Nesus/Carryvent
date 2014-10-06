class VentaMailer < ActionMailer::Base
  default from: "noreplay@carryvent.cl"

  def venta(user, evento, reserva)
  	@user = user
  	@evento = evento
  	@reserva = reserva
  	#@venta = venta
    mail(to: user.email, subject: 'Compra de su(s) Pasaje(s)')
  end
end
