# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150504100916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", id: :serial, force: :cascade do |t|
    t.integer "destination_id", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.binary "encrypted_key", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_attachments_on_destination_id"
  end

  create_table "destinations", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "message_id", null: false
    t.text "encrypted_key", default: "", null: false
    t.text "encrypted_body", default: "", null: false
    t.string "encrypted_body_iv", default: "", null: false
    t.text "encrypted_detail", default: "", null: false
    t.string "encrypted_detail_iv", default: "", null: false
    t.boolean "readed", default: false, null: false
    t.datetime "readed_at"
    t.boolean "detailed", default: false, null: false
    t.datetime "detailed_at"
    t.text "note", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_destinations_on_message_id"
    t.index ["user_id"], name: "index_destinations_on_user_id"
  end

  create_table "logs", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "message_id"
    t.string "action", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_logs_on_created_at"
    t.index ["message_id"], name: "index_logs_on_message_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "username", default: "", null: false
    t.string "label"
    t.jsonb "metadata"
    t.boolean "committee", default: false, null: false
    t.text "pub", default: "", null: false
    t.text "priv", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "index_users_on_label"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "attachments", "destinations"
  add_foreign_key "destinations", "messages"
  add_foreign_key "destinations", "users"
  add_foreign_key "logs", "messages"
  add_foreign_key "logs", "users"
end
