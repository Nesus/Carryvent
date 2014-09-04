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


#Publicador de prueba
print "-Verificando Publicador de prueba\n"

test = Publicador.new(email:'cbarraza@alumnos.inf.utfsm.cl', username: 'Christoper Barraza', password: "11111111", password_confirmation: "11111111")
if test.save
	print "--Publicador Creado\n"
else
	print "--Publicador Existente\n"
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
		ev = publicador.eventos.new(id: row["EVENTO_ID"], name: row["EVENTO_NAME"], information: row["EVENTO_INFORMATION"], subtitle: row["EVENTO_SUBTITLE"], address: row["EVENTO_ADDRESS"], region_id: row["REGION_ID"], city_id: row["COMUNA_ID"])
		ev.raw_write_attribute(:image, row[5])
		ev.save
	end
else
	print "--Eventos ya importados\n"
end

#evento = publocador.eventos.new(name: "Lollapalooza", subtitle: "La quinta edición 
#	de Lollapalooza en suelo chileno comienza su camino a 7 meses para su realización. 
#	El Parque O’Higgins abrirá sus puertas el 14 y 15 de marzo 2015 para recibir
#	 a miles y seguir posicionando a Sudamérica como una de las plazas más importantes
#	 del circuito de festivales en el mundo.", )

#if cant < 6
#	print "--Creando Eventos\n"
#	lat =  -33.036625
#	long =  -71.4837613
#	(1..6).each do |i|
#		i = i.to_s
#		evento = publicador.eventos.new(name: "Evento " + i , subtitle: "Este es el evento " + i, latitude: lat , longitude: long )
#		evento.image = File.open("app/assets/images/"+i+".jpg")
#		evento.save
#		lat = lat + 1
#		long = long + 1
#	end
#else
#	print "--Eventos Existentes\n"
#end 

#Creando carpool de prueba
print "-Creando carpool de prueba\n"
if PublicacionCarpool.count == 0
	user = User.where(email: "gortiz@alumnos.inf.utfsm.cl").first
	evento = Evento.take
	user_evento = user.user_eventos.new(:evento_id => evento.id)
	if user_evento.save
		pub = PublicacionCarpool.new(:user_evento_id => user_evento.id ,:fecha => Date.current, :descripcion => "Este es el carpool de prueba", :desde => "Lugar desde", :asientos_disp => 3, :tipo_vehiculo => "Tipo 1", :celular => "98875647")
		pub.save
	else
		user_evento=user.user_eventos.where(:evento_id => evento.id).first
		pub = PublicacionCarpool.new(:user_evento_id => user_evento.id ,:fecha => Date.current, :descripcion => "Este es el carpool de prueba", :desde => "Lugar desde", :asientos_disp => 3, :tipo_vehiculo => "Tipo 1", :celular => "98875647")
		pub.save
	end
	print "--Carpool creado\n"
else
	print "--Carpool Existente\n"
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
print "FINISH\n"