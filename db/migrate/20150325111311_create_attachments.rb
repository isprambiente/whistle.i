class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :destination, index: true, foreign_key: true, null: false
      t.attachment :file
      t.binary :encrypted_key, null: false, default: ''

      t.timestamps null: false
    end
  end
end
