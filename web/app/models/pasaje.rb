class Pasaje < ActiveRecord::Base
	include PublicActivity::Common
  belongs_to :user_evento
  belongs_to :oferta
  belongs_to :bus
end
