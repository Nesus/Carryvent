ActiveAdmin.register_page "Lista de Pasajeros" do

  menu false

  page_action :listar, :method => :post do
    redirect_to "/admin/lista_de_pasajeros?id=" + params[:id]
  end

  content do
    usuariosEvento = UserEvento.where(evento_id: params[:id])
    usuarios = []
    usuariosEvento.each do |user|
      usuarios += User.where(id: user.user_id).to_a
    end
    table_for usuarios.each do
      column "Nombre", :nombre 
    end  
  end

end