class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\A(?:\+?|\b)[0-9]{11}\b/i

  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, length: { maximum: 255 },format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false }
  validates :last_name, length: { maximum: 25 }
  validates :mobile_num, presence: true, length: { maximum: 14 }, format: {with: VALID_PHONE_NUMBER_REGEX},
    uniqueness: true
  validates :country, length: { maximum: 20 }
  validates :city, length: { maximum: 25 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  #Retorna el hash digest de la cadena dada
  class << self

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    #Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end


  #Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #Forgets a user
  def forget
    update_attribute(:remember_digest, nil)

  end

end
