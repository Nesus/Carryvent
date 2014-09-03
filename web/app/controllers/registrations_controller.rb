class RegistrationsController < Devise::RegistrationsController
	def new
		@ciudades = City.all
		@regiones = Region.all
		super
	end
	
	def create
		super
	end

	def edit
		super
	end
	def update
		super
	end
end
