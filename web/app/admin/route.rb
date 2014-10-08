ActiveAdmin.register Route do


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


  #Filtros
  filter :city, label:"Ciudad"
  filter :region, label:"Region"

  #Nombre del menu
  menu :label => "Rutas"

  #Campos permitidos
  permit_params :city, :region, :points


end
