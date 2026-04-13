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

ActiveRecord::Schema[8.0].define(version: 2026_04_13_120000) do
  create_table "athlete", force: :cascade do |t|
    t.string "profile"
    t.string "name"
    t.integer "age"
    t.string "sport_definition"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "athletes", force: :cascade do |t|
    t.string "profile"
    t.string "name"
    t.integer "age"
    t.string "sport_definition"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_athletes_on_user_id"
  end

  create_table "training_sessions", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "finish_time"
    t.integer "average_speed"
    t.float "total_distance"
    t.date "date"
    t.integer "athlete_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_training_sessions_on_athlete_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "athletes", "users"
  add_foreign_key "training_sessions", "athletes"
end
