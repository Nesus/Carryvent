class ReservaMailer < ActionMailer::Base
  default from: "noreplay@carryvent.cl"

  def reserva(user, evento, reserva)
  	@user = user
  	@evento = evento
  	@reserva = reserva
  	attachments.inline['photo.png'] = File.read('app/assets/images/logoCarryvent.png')
  	attachments.inline['photo1.png'] = File.read('app/assets/images/minilogo.png')
    mail(to: user.email, subject: 'Instrucciones para completar su compra')
  end

end
