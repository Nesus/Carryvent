ActiveAdmin.register Bus do


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
    column "Evento", :evento
    column "Salida",:from
    column "Hora Salida" do |f|
      f.time.strftime("%H:%M:%S") 
    end
    column "Precio" , :price
    column "Cantidad Asientos", :seats
    column "Ruta" do |f|
      f.route.comment
    end
    actions
  end 

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Nuevo Bus" do
      f.input :evento
      f.input :route, :label => "Ruta"
      f.input :price, :label => "Precio"
      f.input :seats, :label => "Cantidad de Asientos"
      f.input :from, :label => "Lugar de salida", :placeholder => "Numero Calle Ciudad Región"
      f.input :time, :label => "Tiempo de salida"
    end
    f.actions
  end

  permit_params :evento_id, :route_id, :price, :seats, :from, :time
end
