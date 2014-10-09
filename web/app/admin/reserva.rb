ActiveAdmin.register Reserva do

  actions :all, except: [:edit, :destroy]
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
    actions
  end


  show do |ad|
    attributes_table do
      row "Evento" do
        ad.user_evento.evento
      end
      row :amount, label: "Cantidad"
      row "Monto" do
        ad.amount * ad.user_evento.evento.bus.price
      end

      if ad.state == 0
        row "Reserva" do
          link_to "Concretar Compra", concretar_reserva_path(ad) , :method => :post
        end
        row "Vencimiento" do 
          ad.ttl
        end
      end

      row "Estado" do
        if ad.state == 0
          "Pendiente"
        elsif ad.state == 1
          "Pagado"
        else
          "Vencido"
        end
      end
      row "Asientos" do
        ad.pasajes_list
      end
    end
  end


end
