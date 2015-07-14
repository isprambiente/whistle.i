class Migrate < ActiveRecord::Migration
  def change
   add_column :attachments, :encrypted_key, :binary, null: false, default: ''
  end
end
