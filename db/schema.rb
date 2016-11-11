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

ActiveRecord::Schema.define(version: 20161111154942) do

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "demand"
    t.integer  "subj_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "units"
    t.integer  "descendants"
    t.integer  "course_type"
    t.text     "timeslot"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "time_start"
    t.datetime "time_end"
    t.integer  "mon_class"
    t.integer  "sat_class"
    t.text     "subjects"
    t.integer  "units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "breaks"
  end

end
