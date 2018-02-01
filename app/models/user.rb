# This model manage the whistle users, define the committee group and manage the RSA keys
class User < ActiveRecord::Base
  include Standardizable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable, :trackable, :timeoutable
  has_many :destinations, dependent: :destroy
  has_many :logs
  attr_accessor :password, :password_confirmation
  attr_reader :adding_key

  scope :committee, -> { where(committee: true).where.not(priv: '') }

  validates :username, presence: true, uniqueness: true
  #validates :label, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }, if: :adding_key
  validates :password_confirmation, presence: true, if: :adding_key
  validates :priv_was, absence: true, if: :adding_key
  validates :committee, presence: true, if: :adding_key
  store_accessor :metadata, :email
  default_scope { order 'label asc'  }

  def label
    super || username
  end

  # Generate a new key if rsa key not exists
  def add_key
    @adding_key = true
    rsa_key = OpenSSL::PKey::RSA.new(2048)
    cipher =  OpenSSL::Cipher::Cipher.new('des3')

      self.priv = rsa_key.to_pem(cipher, password)
      self.pub = rsa_key.public_key.to_pem

    save
  end

  # return the user type (base or committee)
  def status
    committee? ? 'committee' : 'base'
  end

  # RSA decrypyion
  def decrypt(password, text)
    OpenSSL::PKey::RSA.new(priv, password).private_decrypt(text)
  end

  # RSA encryption
  def encrypt(text)
    OpenSSL::PKey::RSA.new(pub).public_encrypt(text)
  end
end
