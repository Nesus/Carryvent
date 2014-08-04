# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#publicador de prueba
test = Publicador.create!(email:'test@test.cl', username: 'test', password: "11111111", password_confirmation: "11111111")

publicador = Publicador.find(1)

(1..6).each do |i|
	i = i.to_s
	evento = publicador.eventos.new(nombre: "Evento " + i , desc: "Este es el evento " + i, imagen: "/assets/"+i+".jpg")
	evento.save
end
