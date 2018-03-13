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

ActiveRecord::Schema.define(version: 20180313170657) do

  create_table "instructions", force: :cascade do |t|
    t.integer "water_amt"
    t.string "water_amt_unit"
    t.string "water_freq"
    t.string "water_freq_unit"
    t.integer "plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.string "sunlight"
    t.string "soil"
    t.string "container_size"
    t.string "drainage"
    t.integer "user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "event"
    t.date "event_date"
    t.string "soil_status"
    t.string "leaf_status"
    t.integer "plant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
