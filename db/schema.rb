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

ActiveRecord::Schema.define(version: 20160121181948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_infos", force: true do |t|
    t.string   "name"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "baka_accounts", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "class_member_id"
  end

  create_table "class_members", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sclass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "done_utu_items", force: true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "user_id"
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
    t.integer  "sclass_id"
    t.integer  "sgroup_id"
  end

  create_table "exams", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.integer  "sgroup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "additional_info_url"
    t.integer  "subject_id"
    t.integer  "lesson_id"
    t.string   "type"
    t.boolean  "passed"
    t.date     "end_date"
    t.integer  "sclass_id"
  end

  create_table "group_belongings", force: true do |t|
    t.integer  "class_member_id"
    t.integer  "sgroup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_timetable_bindings", force: true do |t|
    t.integer  "sgroup_id"
    t.integer  "timetable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", force: true do |t|
    t.date     "holiday_beginning"
    t.date     "holiday_end"
    t.integer  "school_year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "info_item_bindings", force: true do |t|
    t.integer  "additional_info_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_item_bindings", force: true do |t|
    t.integer  "lesson_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "event_name"
  end

  create_table "planned_raking_entries", force: true do |t|
    t.integer  "planned_raking_list_id"
    t.boolean  "finished"
    t.integer  "sorting_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "class_member_id"
    t.integer  "raking_round_id"
    t.string   "grade"
  end

  create_table "planned_raking_lists", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "subject_id"
    t.date     "beginning"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rekt_per_hour"
    t.integer  "sclass_id"
    t.boolean  "planned"
  end

  create_table "raking_rounds", force: true do |t|
    t.integer  "planned_raking_list_id"
    t.integer  "school_year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  create_table "school_days", force: true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "timetable_id"
  end

  create_table "school_years", force: true do |t|
    t.integer  "beginning_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sclasses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_timetable_id"
  end

  create_table "services", force: true do |t|
    t.date     "service_start"
    t.date     "service_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sclass_id"
    t.integer  "first_mate_id"
    t.integer  "second_mate_id"
    t.integer  "school_year_id"
  end

  create_table "sgroups", force: true do |t|
    t.string   "name"
    t.integer  "group_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "timetable_abbr"
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
    t.integer  "sgroup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "additional_info_url"
    t.integer  "subject_id"
    t.integer  "lesson_id"
    t.boolean  "passed"
    t.integer  "sclass_id"
  end

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbr"
  end

  create_table "timetables", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "baka_account_id"
    t.integer  "sclass_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_hidden_events"
    t.boolean  "show_hidden_exams"
    t.boolean  "show_hidden_tasks"
    t.string   "forgot_password_code"
    t.integer  "class_member_id"
    t.string   "name"
    t.integer  "access_level"
  end

end
