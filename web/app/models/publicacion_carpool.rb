class PublicacionCarpool < ActiveRecord::Base
  
  #Pertenece a un usuario que va a un evento
  belongs_to :user_evento
  has_one :user, through: :user_evento
  has_one :evento, through: :user_evento
  has_many :transaccion_carpools

  #Comentarios
  acts_as_commentable

  #Validaciones

  ##Asientos disponibles
  validates :asientos_disp , numericality: { only_integer: true , greater_than_or_equal_to: 0 }
  validates :asientos_disp , presence: true
  
  ##Fecha


end


