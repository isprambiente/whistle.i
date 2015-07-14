class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :status, null: false, default: 0
      t.integer :year, null: false

      t.timestamps null: false
    end
  end
end
