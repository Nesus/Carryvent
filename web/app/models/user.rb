class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true
  validates :nombre, presence: true
  validates :ciudad, presence: true
  validates :region, presence: true

  has_many :red_socials
  has_many :user_eventos
  has_many :eventos , through: :user_eventos
  has_many :pasajes , through: :user_eventos
end
