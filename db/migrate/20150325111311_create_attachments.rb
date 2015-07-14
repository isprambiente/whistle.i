class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :destination, index: true, foreign_key: true, null: false
      t.attachment :file

      t.timestamps null: false
    end
  end
end
