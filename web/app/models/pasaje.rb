class Pasaje < ActiveRecord::Base
  belongs_to :user_evento
  belongs_to :oferta
  belongs_to :bus
end
