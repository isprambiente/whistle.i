class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :message, index: true, foreign_key: true
      t.string :action, null: false, default: ''

      t.timestamps null: false
    end
    add_index :logs, :created_at
  end
end
