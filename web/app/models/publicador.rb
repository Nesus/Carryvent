class Publicador < ActiveRecord::Base
 	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
    before_save :timestamp
    has_many :eventos

  	validates :username, :uniqueness => {:case_sensitive => false }

  	devise 	:database_authenticatable, :registerable,
  			:recoverable, :rememberable, :trackable, 
  			:validatable, :authentication_keys => [:username]

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  private
  def timestamp
    self.last_checked = DateTime.now
  end
end

