class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :status, null: false, default: 0
      t.integer :year, null: false

      t.timestamps null: false
    end
  end
end
