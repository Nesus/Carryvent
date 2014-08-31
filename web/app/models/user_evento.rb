class UserEvento < ActiveRecord::Base
  #Relaciones
  belongs_to :user
  belongs_to :evento

  has_many :pasajes
  has_one :publicacion_carpool

  #Validaciones
  validate :user_id , presence: true
  validate :evento_id, presence: true
end
