class Evento < ActiveRecord::Base
	has_many :user_eventos
	has_many :user , through: :user_eventos
end
