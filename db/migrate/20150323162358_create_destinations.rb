class CreateDestinations < ActiveRecord::Migration[5.0]
  def change
    create_table :destinations do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :message, index: true, foreign_key: true, null: false
      t.text :encrypted_key, null: false, default: ''
      t.text :encrypted_body, null: false, default: ''
      t.string :encrypted_body_iv, null: false, default: ''
      t.text :encrypted_detail, null: false, default: ''
      t.string :encrypted_detail_iv, null: false, default: ''
      t.boolean :readed, null: false, default: false
      t.datetime :readed_at
      t.boolean :detailed, null: false, default: false
      t.datetime :detailed_at
      t.text :note, null: false, default: ''

      t.timestamps null: false
    end
  end
end
