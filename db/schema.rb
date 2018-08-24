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

ActiveRecord::Schema.define(version: 2018_08_07_042110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name", default: ""
    t.string "kind", null: false
    t.string "cover_image_url", default: ""
    t.text "description", default: ""
  end

  create_table "conversations", force: :cascade do |t|
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.bigint "company_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_messages_on_company_id"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "conversation_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_participants_on_company_id"
    t.index ["conversation_id"], name: "index_participants_on_conversation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name", default: ""
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "url", null: false
    t.string "name", null: false
    t.string "thumbnail", default: ""
    t.text "description", default: ""
    t.bigint "genre_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_videos_on_company_id"
    t.index ["genre_id"], name: "index_videos_on_genre_id"
  end

  create_table "views", force: :cascade do |t|
    t.bigint "video_id"
    t.jsonb "metadata", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_views_on_video_id"
  end

  add_foreign_key "messages", "companies"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "participants", "companies"
  add_foreign_key "participants", "conversations"
  add_foreign_key "videos", "companies"
  add_foreign_key "videos", "genres"
  add_foreign_key "views", "videos"
end
