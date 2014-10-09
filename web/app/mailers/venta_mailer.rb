class VentaMailer < ActionMailer::Base
  default from: "noreplay@carryvent.cl"

  def venta(reserva)
  	@reserva = reserva	
  	@user = reserva.user_evento.user
  	@evento = reserva.user_evento.evento
  	attachments.inline['photo.png'] = File.read('app/assets/images/logoCarryvent.png')
  	attachments.inline['photo1.png'] = File.read('app/assets/images/minilogo.png')
    mail(to: @user.email, subject: 'Compra de su(s) Pasaje(s)')
  end
end
