class Route < ActiveRecord::Base
  #Para poder guardar un arreglo de puntos
  serialize :points

  #Pertenece a una ciudad y region
  belongs_to :city
  belongs_to :region

  #Tiene muchos buses relacionados
  has_many :buses
end
