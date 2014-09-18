class ReservaMailer < ActionMailer::Base
  default from: "noreplay@carryvent.cl"

  def reserva(user, evento, reserva)
  	@user = user
  	@evento = evento
  	@reserva = reserva
    mail(to: user.email, subject: 'Instrucciones para completar su compra')
  end

end
