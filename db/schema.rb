# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161111232855) do

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "day"
    t.integer  "code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_weight"
    t.integer  "location"
    t.integer  "course_type"
    t.integer  "timeslot"
    t.integer  "priority"
  end

  create_table "schedule_courses", force: :cascade do |t|
    t.integer  "schedule_id"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schedule_courses", ["course_id"], name: "index_schedule_courses_on_course_id"
  add_index "schedule_courses", ["schedule_id"], name: "index_schedule_courses_on_schedule_id"

  create_table "schedules", force: :cascade do |t|
    t.time     "time_start"
    t.time     "time_end"
    t.integer  "mon_class"
    t.integer  "sat_class"
    t.text     "subjects"
    t.integer  "units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "breaks"
  end

end
