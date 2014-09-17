ActiveAdmin.register Evento do
  filter :name
  filter :date
  filter :time
  filter :category
  filter :region
  filter :city
  

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
  config.per_page = 10
  index do
    column "Nombre",:name
    column "Subtitulo",:subtitle
    column "Direccion",:address
    column "Informacion Extra",:information
    column "Fecha",:date
    column "Hora",:time
    column "Categoria", :category
    actions
  end

end
