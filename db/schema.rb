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

ActiveRecord::Schema.define(version: 20150305160846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baka_accounts", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "day_teachers", force: true do |t|
    t.date     "date"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "details_accesses", force: true do |t|
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "done_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "done_exams", force: true do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "done_tasks", force: true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.date     "event_start"
    t.date     "event_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "additional_info_url"
    t.date     "pay_date"
    t.integer  "price"
  end

  create_table "exams", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.integer  "group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "additional_info_url"
    t.integer  "subject_id"
  end

  create_table "lessons", force: true do |t|
    t.string   "room"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_day_id"
    t.integer  "teacher_id"
    t.boolean  "not_normal"
    t.integer  "subject_id"
    t.integer  "serial_number"
    t.string   "not_normal_comment"
  end

  create_table "school_days", force: true do |t|
    t.date     "date"
    t.integer  "weekday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "timetable_id"
  end

  create_table "services", force: true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.date     "service_start"
    t.date     "service_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snoozed_events", force: true do |t|
    t.integer  "user_id"
    t.datetime "snooze_date"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snoozed_exams", force: true do |t|
    t.integer  "user_id"
    t.datetime "snooze_date"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snoozed_tasks", force: true do |t|
    t.integer  "user_id"
    t.datetime "snooze_date"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.integer  "group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "additional_info_url"
    t.integer  "subject_id"
  end

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbr"
  end

  create_table "timetables", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "baka_account_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.boolean  "admin"
    t.integer  "group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "show_hidden_events"
    t.boolean  "show_hidden_exams"
    t.boolean  "show_hidden_tasks"
    t.string   "forgot_password_code"
  end

end
