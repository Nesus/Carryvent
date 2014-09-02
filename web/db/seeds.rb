# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

#Usuario de prueba
test = User.new(email: 'test@test.cl', nombre: "Testito Testoneo", password: "11111111" , password_confirmation: "11111111")
test.save

#Publicador de prueba
test = Publicador.new(email:'test@test.cl', username: 'test', password: "11111111", password_confirmation: "11111111")
test.save

#Buscamos el publicador
publicador = Publicador.find(1)

#Insertamos eventos de prueba

cant = Evento.count

if cant < 6
	(1..6).each do |i|

		i = i.to_s
		evento = publicador.eventos.new(name: "Evento " + i , subtitle: "Este es el evento " + i)
		evento.image = File.open("app/assets/images/"+i+".jpg")
		evento.save
	end
end 

#Importando datos de ciudad y regiones

regiones_text = File.read("db/dbCiudades/regiones.csv")	
regiones = CSV.parse(regiones_text, headers: true)

comunas_text = File.read("db/dbCiudades/comunas.csv")	
comunas = CSV.parse(comunas_text, headers: true)

if Region.count == 0
	regiones.each do |row|
		reg = Region.new(id: row["REGION_ID"], name: row["REGION_NOMBRE"], short_name: row["REGION_ID"].to_s + "° Región")
		reg.save
	end
end
