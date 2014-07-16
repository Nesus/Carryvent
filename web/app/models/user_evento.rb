class UserEvento < ActiveRecord::Base
  belongs_to :user
  belongs_to :evento
  has_many :pasaje
  has_many :publicacion_carpool
end
