class Pasaje < ActiveRecord::Base
  belongs_to :user_evento
  has_one :oferta
end
