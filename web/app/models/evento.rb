class Evento < ActiveRecord::Base
	has_many :user_eventos
	has_many :users , through: :user_eventos

	belongs_to :publicador

	validates :nombre, presence: true
	validates :desc, presence: true
	validates :publicador_id, presence: true
end
