class Reserva < ActiveRecord::Base
	#########################
	#  State #  Significado #
	#  	 0	 #   Pendiente  #
	# 	 1   #   Aceptado   #
	#    2   #   Expirado   #
	#########################

	scope :pendiente,  -> { where(state: 0) }
	scope :aceptado,  -> { where(state: 1) }
	scope :expirado,  -> { where(state: 2) }
	#Notificaciones
	include PublicActivity::Common

	#Crear el codigo unico
	before_create :generate_code
	#Crear muerte de pasaje
	before_create :generate_ttl
	
	#Relaciones	
	belongs_to :user_evento

	has_many :pasajes


	#Para guardar el punto
	serialize :point

	private
		def generate_ttl
			self.ttl = DateTime.current + 3.days
  	    	scheduler = Rufus::Scheduler.new
  	    	job_id = scheduler.in self.ttl.to_s do
  	    		if Reserva.find(self.id).state == 0
  	    			self.update(:state => 2)
  	    		end
  	    	end
  	    	self.job_id = job_id

		end

	  	def generate_code
    		self.code = loop do
      			random_token = SecureRandom.urlsafe_base64(nil, false)
      			break random_token unless Reserva.exists?(code: random_token)
   	 		end
  		end
end
