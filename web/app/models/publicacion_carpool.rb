class PublicacionCarpool < ActiveRecord::Base
  
  #Pertenece a un usuario que va a un evento
  belongs_to :user_evento
  has_one :user, through: :user_evento
  has_one :evento, through: :user_evento
  has_many :transaccion_carpools

  #Comentarios
  acts_as_commentable

  #Validaciones
  validates :asientos_disp , numericality: { only_integer: true , greater_than_or_equal_to: 0 }
  validates :asientos_disp , presence: true
  validates :fecha, presence: true
  validates :desde, presence: true
  validates :celular, presence: true
  validates :hora_desde, presence: true
  
  ##Asientos disponibles
  def asientos_libres
    asientos_disp - transaccion_carpools.sum(:asientos, :conditions => {:aceptado => true})
  end

  def date_time
    merged_datetime = DateTime.new(fecha.year, fecha.month,
                               fecha.day, hora_desde.hour,
                               hora_desde.min, hora_desde.sec)
  end

end


