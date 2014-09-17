ActiveAdmin.register Category, :as => "Categoria" do
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

  #Parametros Permitidos
  permit_params :name
  
  #Cambiar el nombre del menu
  menu :label => "Categorias"

  #Filtros
  filter :name, label: "Nombre"
  #Columnas que se ven en el indice
  index do
    column "Nombre",:name
    actions
  end 

  show do |ad|
    attributes_table do
      row :id
      row :name
    end
  end
end
