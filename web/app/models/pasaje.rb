class Pasaje < ActiveRecord::Base
	before_create :generate_code


	#Relaciones
  belongs_to :user_evento
 	belongs_to :oferta
  belongs_to :bus

  	private
	  	def generate_code
    		self.codigo = loop do
      			random_token = SecureRandom.urlsafe_base64(nil, false)
      			break random_token unless Pasaje.exists?(codigo: random_token)
   	 		end
  		end
end
