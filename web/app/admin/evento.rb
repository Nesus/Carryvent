ActiveAdmin.register Evento do

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
  filter :date
  filter :time
  filter :category
  filter :region
  filter :city

  #Orden en que se mostraran
  config.sort_order = "id_asc"

  #Parametros permitidos
  permit_params :name, :subtitle,
               :address, :information, 
               :organization_id, :category_id, 
               :city_id, :region_id, :image, 
               :date , :time

  #Filas a mostrar
  show do |ad|
    attributes_table do
      row "Imagen" do
        image_tag(ad.image.small.url)
      end
      row :name, label: "Nombre"
      row :subtitle, label: "Subtitulo"
      row :address, label: "Direccion"
      row :organization, label: "Organización"
      row :category , label: "Categoria"
      row :city, label: "Ciudad"
      row :region, label: "Region"
      row :date, label:"Fecha"
      row :time, label: "Hora"
    end
  end


  #Columnas del index
  index do
    column "Foto" do |f|
      image_tag(f.image.small.url)
    end
    column "Nombre",:name
    column "Subtitulo",:subtitle
    column "Direccion",:address
    column "Informacion Extra",:information
    column "Fecha",:date
    column "Hora",:time
    column "Categoria", :category
    actions
  end


  #Form para editar y crear
  form(:html => { :multipart => true }) do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Datos Evento" do
      f.input :name, :label => "Nombre"
      
      f.input :picture,:label => "Imagen", :as => :file
      
      f.input :information
      f.input :category
      f.input :organization
    end

    f.inputs "Datos de direccion" do
      f.input :region, :label => "Region"
      f.input :city , :label => "Ciudad"
      f.input :address, :label => "Direccion"
    end

    f.inputs "Fecha y Hora" do
      f.input :date, :label =>"Fecha"
      f.input :time, :label => "Hora"
    end
    f.actions
  end
end
