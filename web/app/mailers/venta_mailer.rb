class VentaMailer < ActionMailer::Base
  default from: "noreplay@carryvent.cl"

  def venta(reserva)
  	@reserva = reserva	
  	@user = reserva.user_evento.user
  	@evento = reserva.user_evento.evento
  	@reserva.pasajes.each do |r|
    	qr = RQRCode::QRCode.new( r.codigo, :size => 4, :level => :h )
    	@png = qr.to_img.resize(150,150).save("tmp/#{@user.nombre.gsub(" ", "-")}_#{@evento.name.gsub(" ", "-")}_Asiento#{r.asiento}.png")
    	attachments["#{@user.nombre.gsub(" ", "-")}_#{@evento.name.gsub(" ", "-")}_Asiento#{r.asiento}.png"] = File.read("tmp/#{@user.nombre.gsub(" ", "-")}_#{@evento.name.gsub(" ", "-")}_Asiento#{r.asiento}.png")
     end  
  	attachments.inline['photo.png'] = File.read('app/assets/images/logoCarryvent.png')
  	attachments.inline['photo1.png'] = File.read('app/assets/images/minilogo.png')
    mail(to: @user.email, subject: 'Compra de su(s) Pasaje(s)')
  end
end