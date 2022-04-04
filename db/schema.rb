# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_04_060426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.date "held_on", null: false
    t.string "open", default: "未定"
    t.string "start", default: "未定"
    t.integer "price"
    t.string "artist", default: "未定"
    t.bigint "livehouse_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["held_on"], name: "index_events_on_held_on"
    t.index ["livehouse_id"], name: "index_events_on_livehouse_id"
    t.index ["title", "held_on"], name: "for_upsert", unique: true
  end

  create_table "livehouses", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.text "url", null: false
    t.string "nearest_station"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "events", "livehouses"
end
