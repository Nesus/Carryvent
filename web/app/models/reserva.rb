class Reserva < ActiveRecord::Base

	before_create :generate_code
	
	belongs_to :user_evento

	has_many :pasajes

	private
	  	def generate_code
    		self.code = loop do
      			random_token = SecureRandom.urlsafe_base64(nil, false)
      			break random_token unless Reserva.exists?(code: random_token)
   	 		end
  		end
end
