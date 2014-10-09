class RegistrationsController < Devise::RegistrationsController

	def new
		super
	end

	def create
		super
	end

	def edit
		@categorias = Category.all
		gustosUsuario = Gusto.where(user_id: @user.id)
		@gustos = []
		gustosUsuario.each do |gu|
			categoria = Category.find(gu.category_id)
			@gustos.push(categoria.id)
		end
	end

	def update
		gustosUsuario = Gusto.where(user_id: @user.id)
		gustos = []
		gustosUsuario.each do |gu|
			categoria = Category.find(gu.category_id)
			gustos.push(categoria.id)
		end

		@g = gustos
		@g2 = params[:gusto]

		params[:gusto].each do |ng|
			if gustos.include?(ng[0].to_i) and ng[1] == "0"
				quitarGusto = Gusto.where("user_id = " + current_user.id.to_s + " and category_id = " + ng[0])
				Gusto.delete(quitarGusto[0].id)
			elsif !gustos.include?(ng[0].to_i) and ng[1] == "1"
				nuevoGusto = Gusto.new(:user_id => current_user.id, :category_id => ng[0].to_i)
				nuevoGusto.save
			end
		end
		
		redirect_to perfil_user_path(current_user.id)
	end
end 
