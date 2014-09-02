class OrganizationController < ApplicationController
	def new
		@organization = Organization.new		
	end

	def create
		organization = Organization.new(organization_params)
		if organization.save
			redirect_to mostrar_organization_path(organization)
		else
			#AGREGAR ERROR
			redirect_to publicar_organization_path
		end
	end

	def show
		@organization = Organization.find(params[:id])
	end

	def edit
		@organization = Organization.find(params[:id])
	end

	def update
		organization = Organization.find(params[:id])
		organization.update(organization_params)
	end

	private

	def organization_params
		params.require(:organization).permit(:name, :contact_person, :phone, :facebook, :twitter, :picture)
	end

end
