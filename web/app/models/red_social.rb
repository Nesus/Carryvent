class RedSocial < ActiveRecord::Base
  #Pertenece al usuario que la agregó
  belongs_to :user

  #Valida que todo exista
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(uid: auth.uid, provider: auth.provider) if identity.nil?
    identity
  end
end
