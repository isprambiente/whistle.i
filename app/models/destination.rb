# This model contain the body message and the AES key for decrypt.
# The AES key is crypted with the user RSA key
class Destination < ActiveRecord::Base
  include Standardizable
  belongs_to :user
  belongs_to :message
  has_many :attachments
  accepts_nested_attributes_for :attachments, reject_if: :all_blank
  attr_encrypted :body, key: proc { |d| d.key }
  attr_encrypted :detail, key: proc { |d| d.key }

  validates :user, presence: true
  validates :body, presence: true
  validates :detail, presence: true
  validates :encrypted_key, presence: true
  validates :note, presence: true, if: :detailed?

  # set the RSA password for decrypt the key
  def password=(var)
    @password = var
    @key = OpenSSL::PKey::RSA.new(user.priv, @password).private_decrypt(encrypted_key)
    @password
  end

  # Return the a new AES key if encrypted_key is blank else try to decrypt the AES key
  def key
    @key = SecureRandom.base64(128).to_s if @key.blank?
    self.encrypted_key = OpenSSL::PKey::RSA.new(user.pub).public_encrypt(@key) if encrypted_key.blank?
    @key
  end
end
