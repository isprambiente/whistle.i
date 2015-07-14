# This model manage the attachments sended with the message
# All the attachments are crypted whit the destination key
class Attachment < ActiveRecord::Base
  include Standardizable
  belongs_to :destination
  has_attached_file :file, path: ':rails_root/private/:id_partition/:id.:extension'
  do_not_validate_attachment_file_type :file

  before_create :add_key
  after_save :crypt_file, on: :create

  # try to decrypt the attachment
  def file_streaming(password)
    key = destination.user.decrypt(password, encrypted_key)
    ` openssl aes-256-cbc -d -a -in #{file.path}.enc  -pass pass:#{key} `
  end

  private

  # Return the a new AES key if encrypted_key is blank else try to decrypt the AES key
  def add_key
    @key = SecureRandom.base64(128).to_s
    self.encrypted_key = destination.user.encrypt(@key)
  end

  # crypt the attachemnts and remove the original file
  def crypt_file
    Rails.logger.info system("openssl aes-256-cbc -a -salt -in #{file.path} -out #{file.path}.enc -pass pass:#{@key} && rm #{file.path}")
  end
end
