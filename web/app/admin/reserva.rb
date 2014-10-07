ActiveAdmin.register Reserva do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  index do
    column "Evento" do |f|
      link_to f.user_evento.evento.name, admin_evento_path(f.user_evento.evento)
    end
    column "Cantidad de asientos", :amount
    column "Vencimiento", :ttl
    column "Estado" do |f|
      if f.state == 0
        "Pendiente"
      elsif f.state == 1
        "Ya pagado"
      else
        "Vencido"
      end
    end
    column "Finalizar Reserva" do |f|
      if f.state == 0
        link_to "Concretar Compra", concretar_reserva_path(f) , :method => :post
      end
    end
  end
end
