ActiveAdmin.register_page "Ruta dinámica" do

  menu false
  page_action :ruta, :method => :post do
    redirect_to "/admin/ruta_dinamica?id=" + params[:id]
  end

  content do
    evento = Evento.find(params[:id])

    @puntos = evento.reservas.aceptado.map(&:point)
    @inicio = evento
    @fin = evento.bus

    render partial: 'ruta', locals: {puntos: @puntos, inicio: @inicio, fin: @fin}

  end

end