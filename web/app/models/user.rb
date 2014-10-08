class User < ActiveRecord::Base
  #Para request
  require 'net/http'
  require "uri"

  #Para subir fotos
  mount_uploader :foto, FotoUploader


  acts_as_messageable
  #Comprobar si el email es valido
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:email]

  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]

#  before_action :set_user, :finish_signup

  validates :email, presence: true
  validates :nombre, presence: true
  #validates :ciudad, presence: true

  #Relaciones
  has_many :red_socials
  has_many :transaccion_carpools
  
  has_many :user_eventos
  has_many :eventos , through: :user_eventos
  has_many :publicacion_carpools, through: :user_eventos
  has_many :pasajes, through: :user_eventos

  has_many :gustos
  has_many :categories, through: :gustos

  has_many :rankings

  belongs_to :city
  belongs_to :region

  def ranking
    sum = self.rankings.sum(:value,  :conditions => {:assist => true})
    if sum
      return sum
    else
      return 0
    end
  end


  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = RedSocial.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          nombre: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20],
          direccion: auth.info.location
        )

        access_token = auth.credentials.token
        uid = auth.uid
        location = get_facebook_location(uid, access_token)[0]
        city = location["current_location"]["city"]
        region = location["current_location"]["state"]
        ciudad = City.where(:name => city).first
        if ciudad
          region = ciudad.region
        end
        if ciudad and region
          user.city_id = ciudad.id
          user.region_id = region.id
        end
        user.facebook_password = true
        user.remote_foto_url = auth.info.image.sub("_normal", "").sub("http://","https://") + "?type=large"

        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def self.http_get(domain,path,params)

    path = unless params.blank?
        path + "?" + params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
      else
        path
    end

    uri = URI.parse(domain+path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    response = response.body
    response = JSON.parse(response)
    return response
  end

  def self.get_facebook_location(uid, access_token)
      
      params = {
          :query => 'SELECT current_location FROM user WHERE uid='+uid ,
          :format => 'json',
          :access_token => access_token
      }
      http = http_get('https://api.facebook.com', '/method/fql.query', params)
      print http
      return http

  end
end
