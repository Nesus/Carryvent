ActiveAdmin.register_page "Lista de Pasajeros" do

  menu false
  page_action :listar, :method => :post do
    redirect_to "/admin/lista_de_pasajeros?id=" + params[:id]
  end

  content do
    evento = Evento.find(params[:id])
    table_for evento.reservas.aceptado.each do
      column "Nombre" do |f|
        f.user_evento.user.nombre
      end
      column "Cantidad Pasajes" do |f|
        f.amount.to_s + " Pasajes"
      end
      column "Lugar donde se bajará" do |f|
        f.point[:desc]
      end
      column "Asientos" do |f|
        f.pasajes_list
      end
    end 
  end

end