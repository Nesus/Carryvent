class ReservaMailer < ActionMailer::Base
  default from: "noreplay@carryvent.cl"

  def reserva(email)
    @url  = 'http://example.com/login'
    mail(to: email, subject: 'Welcome to My Awesome Site')
  end

end
