# This model contain the body message and the AES key for decrypt.
# The AES key is crypted with the user RSA key
class Destination < ActiveRecord::Base
  include Standardizable
  belongs_to :user
  belongs_to :message
  has_many :attachments
  accepts_nested_attributes_for :attachments, reject_if: :all_blank
  attr_encrypted :body, key: :key, allow_empty_value: true
  attr_encrypted :detail, key: :key, allow_empty_value: true

  #before_validation :add_key, on: :create

  validates :user, presence: true
  validates :body, presence: true
  validates :detail, presence: true
  validates :encrypted_key, presence: true
  validates :note, presence: true, if: :detailed?

  # set the RSA password for decrypt the key
  def password=(var)
    @password = var
    @key = OpenSSL::PKey::RSA.new(user.priv, @password).private_decrypt(Base64.decode64(encrypted_key))
    return @password
  end

  # Return the a new AES key if encrypted_key is blank else try to decrypt the AES key
  def key
    @key = SecureRandom.random_bytes(32).to_s if @key.blank?
    self.encrypted_key = Base64.encode64(OpenSSL::PKey::RSA.new(user.pub).public_encrypt(@key)) if encrypted_key.blank?
    @key
  end

  private

  def add_key
    self.encrypted_body_iv = SecureRandom.random_bytes(12)
    self.encrypted_detail_iv = SecureRandom.random_bytes(12)
    @key = SecureRandom.random_bytes(32).to_s
  end
end
