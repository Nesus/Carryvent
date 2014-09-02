class Pasaje < ActiveRecord::Base
  belongs_to :user_evento
  belongs_to :oferta
end
