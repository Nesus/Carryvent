class UserEvento < ActiveRecord::Base
  belongs_to :user
  belongs_to :evento

  has_many :pasajes
  has_one :publicacion_carpool
end
