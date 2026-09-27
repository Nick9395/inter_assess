# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_09_28_120000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "education_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "enrolled_on", null: false
    t.string "faculty"
    t.date "graduated_on"
    t.text "learned"
    t.integer "position", default: 0, null: false
    t.string "school_name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "position"], name: "index_education_entries_on_user_id_and_position"
    t.index ["user_id"], name: "index_education_entries_on_user_id"
  end

  create_table "practices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "question_count", null: false
    t.string "status", default: "in_progress", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "status"], name: "index_practices_on_user_id_and_status"
    t.index ["user_id"], name: "index_practices_on_user_id"
  end

  create_table "turns", force: :cascade do |t|
    t.text "answer_text"
    t.datetime "created_at", null: false
    t.string "kind", default: "master", null: false
    t.string "master_key"
    t.bigint "practice_id", null: false
    t.text "question_text", null: false
    t.integer "sequence", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_id", "sequence"], name: "index_turns_on_practice_id_and_sequence", unique: true
    t.index ["practice_id"], name: "index_turns_on_practice_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "work_entries", force: :cascade do |t|
    t.text "achievement"
    t.text "company_description", null: false
    t.datetime "created_at", null: false
    t.date "joined_on", null: false
    t.date "left_on"
    t.integer "position", default: 0, null: false
    t.string "role"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "position"], name: "index_work_entries_on_user_id_and_position"
    t.index ["user_id"], name: "index_work_entries_on_user_id"
  end

  add_foreign_key "education_entries", "users"
  add_foreign_key "practices", "users"
  add_foreign_key "turns", "practices"
  add_foreign_key "work_entries", "users"
end
