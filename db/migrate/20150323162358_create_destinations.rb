class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :message, index: true, foreign_key: true, null: false
      t.binary :encrypted_key, null: false, default: ''
      t.binary :encrypted_body, null: false, default: ''
      t.binary :encrypted_detail, null: false, default: ''
      t.boolean :readed, null: false, default: false
      t.datetime :readed_at
      t.boolean :detailed, null: false, default: false
      t.datetime :detailed_at
      t.text :note, null: false, default: ''

      t.timestamps null: false
    end
  end
end
