ActiveAdmin.register Organization, :as => "Organizaciones" do


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
  filter :name

  #Nombre del menu
  menu :label => "Organizaciones"

  #Parametros permitidos
  permit_params :name, :contact_person, :phone, :facebook, :twitter, :picture

  #Orden en que se mostraran
  config.sort_order = "id_asc"

  #Columnas a mostrar
  index do
    column "ID",:id 
    column "Foto" do |f|
      image_tag(f.picture.thumb.url)
    end
    column "Nombre", :name
    column "Twitter", :twitter
    column "Faceboon", :facebook
    column "Contacto", :contact_person
    column "Telefono", :phone
    actions
  end

  #Filas a mostrar
  show do |ad|
    attributes_table do
      row "Imagen" do
        image_tag(ad.picture.small.url)
      end
      row :name, label: "Nombre"
      row :twitter
      row :facebook
      row :contact_person, label: "Contacto"
      row :phone , label: "Telefono"
    end
  end

  #Form para editar y crear
  form(:html => { :multipart => true }) do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Datos organizacion" do
      f.input :name, :label => "Nombre"
      
      f.input :picture,:label => "Imagen", :as => :file
      
      f.input :facebook
      f.input :twitter
    end

    f.inputs "Datos de contacto" do
      f.input :contact_person, :label => "Nombre"
      f.input :phone, :label => "Telefono"
    end
    f.actions
  end

end
