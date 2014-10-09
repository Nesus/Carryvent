# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

#Usuario de prueba
print "-Verificando Usuario de prueba\n"
user = User.new(email: 'gortiz@alumnos.inf.utfsm.cl', nombre: "Germán Ortiz", password: "11111111" , password_confirmation: "11111111", city_id: 4101 , region_id: 4)
if user.save
	print "--Usuario Creado\n"
else
	print "--Usuario Existente\n"
end

user = User.new(email: 'cbarraza@alumnos.inf.utfsm.cl', nombre: "Christoper Barraza", password: "11111111" , password_confirmation: "11111111", city_id: 4101 , region_id: 4)
if user.save
	print "--Usuario Creado\n"
else
	print "--Usuario Existente\n"
end

#Gustos
print "-Agregando Gustos\n"
if Gusto.count == 0
	gusto = Gusto.new(user_id: '1', category_id: '1')
	gusto.save
	print "--Gustos agregados\n"
else
	print "--Gustos existente\n"
end

#Publicador de prueba
print "-Verificando Publicador de prueba\n"

test = Publicador.new(email:'cbarraza@alumnos.inf.utfsm.cl', username: 'Christoper Barraza', password: "11111111", password_confirmation: "11111111")
if test.save
	print "--Publicador Creado\n"
else
	print "--Publicador Existente\n"
end




#Importando datos de ciudad y regiones
print "-Importando tablas de ciudades y regiones\n"
regiones_text = File.read("db/dbCiudades/regiones.csv")	
regiones = CSV.parse(regiones_text, headers: true)

comunas_text = File.read("db/dbCiudades/comunas.csv")	
comunas = CSV.parse(comunas_text, headers: true)

if Region.count == 0
	print "--Importando regiones\n"
	regiones.each do |row|
		reg = Region.new(id: row["REGION_ID"], name: row["REGION_NOMBRE"], short_name: row["REGION_ID"].to_s + "° Región")
		reg.save
	end
else
	print "--Regiones ya importadas\n"
end

if City.count == 0
	print "--Importando ciudades\n"
	comunas.each do |row|
		region_id = row["COMUNA_PROVINCIA_ID"][0..-2]
		cit = City.new(id: row["COMUNA_ID"], region_id: region_id, name: row["COMUNA_NOMBRE"] )
		cit.save
	end
else
	print "--Ciudades ya importadas\n"
end





#Buscamos el publicador
publicador = Publicador.first

#Insertamos eventos de prueba
print "-Creando eventos de prueba\n"

#cant = Evento.count
eventos_text = File.read("db/dbEventos/eventos.csv")	
eventos = CSV.parse(eventos_text, headers: true)
if Evento.count == 0
	print "--Importando evento\n"
	eventos.each do |row|
		ev = publicador.eventos.new(name: row["EVENTO_NAME"], information: row["EVENTO_INFORMATION"], subtitle: row["EVENTO_SUBTITLE"], address: row["EVENTO_ADDRESS"], category_id: row["EVENTO_CATEGORY"], region_id: row["REGION_ID"], city_id: row["COMUNA_ID"], date: row["EVENTO_DATE"], time: row["EVENTO_TIME"])
		#ev.raw_write_attribute(:image, row[6])
		ev.image = File.open("app/assets/images/"+(Evento.count+1).to_s+".jpg")
		ev.save
	end
else
	print "--Eventos ya importados\n"
end

print "-Creando Ruta de Prueba\n"

if Route.count ==0
	print "--Creando Ruta\n"
	#Cambiar esto por una ruta de verdad
	city = City.take
	points = [{:lat => -33.044249, :long => -71.604808, :desc => "Jumbo Valparaíso, Av. Argentina"},
				{:lat => -33.025110, :long => -71.560471, :desc => "Alvarez con Ecuador"},
				{:lat => -33.026299, :long => -71.553056, :desc => "Alvarez con Plaza Sucre"},
				{:lat => -33.024282, :long => -71.549385, :desc => "Arlegui con Quillota"},
				{:lat => -33.025318, :long => -71.552046, :desc => "Plaza de Viña"},
				{:lat => -33.01989, :long => -71.55112, :desc => "4 Norte con Av. Libertad"},
				{:lat => -33.009769, :long => -71.548859, :desc => "14 Norte con Av. Libertad"},
				{:lat => -33.022520, :long => -71.547757, :desc => "Quillota con 1 Norte"},
				{:lat => -33.031376, :long => -71.531951, :desc => "1 Norte, Plaza Miraflores"}]
	ruta = Route.new(points: points, city: city, region: city.region, comment: "Ruta de Prueba" )
	ruta.save
else 
	print "--Ruta ya creada \n"
end


print "-Creando Bus de Prueba\n"
if Bus.count == 0
	evento = Evento.take
	ruta = Route.take
	price = 10000
	seats= 46
	from = "Terminal rodoviario, Valparaiso, Chile"
	time = Time.current

	bus = Bus.new(evento: evento, route: ruta, price: price, seats: seats, from: from, time:time)
	bus.save
end

#Creando carpool de prueba
print "-Creando carpool de prueba\n"
if PublicacionCarpool.count == 0
	user = User.where(email: "gortiz@alumnos.inf.utfsm.cl").first
	user2 = User.where(email: "cbarraza@alumnos.inf.utfsm.cl").first
	evento = Evento.take
	evento2 = Evento.find(2)
	user_evento = user.user_eventos.new(:evento_id => evento.id)
	user_evento2 = user2.user_eventos.new(:evento_id => evento2.id)
	if user_evento.save
		pub = PublicacionCarpool.new(:user_evento_id => user_evento.id ,:fecha => Date.current, :descripcion => "Este es el carpool de prueba", :desde => "Chapilca, 761, La Serena, Chile", :asientos_disp => 3, :tipo_vehiculo => "Sedan", :celular => "98875647", :hora_desde => Time.now)
		pub.save
	else
		user_evento=user.user_eventos.where(:evento_id => evento.id).first
		pub = PublicacionCarpool.new(:user_evento_id => user_evento.id ,:fecha => Date.current, :descripcion => "Este es el carpool de prueba", :desde => "Chapilca, 761, La Serena, Chile", :asientos_disp => 3, :tipo_vehiculo => "Sedan", :celular => "98875647", :hora_desde => Time.now)
		pub.save
	end
	if user_evento2.save
		pub = PublicacionCarpool.new(:user_evento_id => user_evento2.id ,:fecha => Date.current, :descripcion => "Este es el carpool de prueba", :desde => "Chapilca, 761, La Serena, Chile", :asientos_disp => 3, :tipo_vehiculo => "Sedan", :celular => "98875647", :hora_desde => Time.now)
		p1=pub.save
	else
		user_evento2=user2.user_eventos.where(:evento_id => evento.id).first
		pub = PublicacionCarpool.new(:user_evento_id => user_evento2.id ,:fecha => Date.current, :descripcion => "Este es el carpool de prueba", :desde => "Chapilca, 761, La Serena, Chile", :asientos_disp => 3, :tipo_vehiculo => "Sedan", :celular => "98875647", :hora_desde => Time.now)
		p1=pub.save
	end
	if p1
		trans = user.transaccion_carpools.new(:asientos => 1,  :publicacion_carpool_id => pub.id , :aceptado => true)
	end 


	print "--Carpool creado\n"
else
	print "--Carpool Existente\n"
end

#Importando Categorias
print "-Importando Categorias\n"
categorias_text = File.read("db/dbCategorias/categorias.csv")
categorias = CSV.parse(categorias_text, headers: true)

if Category.count == 0
	categorias.each do |row|
		cat = Category.new(name: row["CATEGORIA_NAME"])
		cat.save
	end
	print "--Categorias importadas\n"
else
	print "--Categorias ya fueron importadas\n"
end

print "FINISH\n"