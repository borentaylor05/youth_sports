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

ActiveRecord::Schema.define(version: 20140517074305) do

  create_table "children", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.date     "birthday"
    t.boolean  "physicalComplete"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coach_comments", force: true do |t|
    t.string   "body"
    t.integer  "coach_id"
    t.boolean  "announcement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coach_comments", ["coach_id", "created_at"], name: "index_coach_comments_on_coach_id_and_created_at"

  create_table "coach_teams", force: true do |t|
    t.integer  "teamID"
    t.integer  "coachID"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coaches", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.integer  "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parent_comments", force: true do |t|
    t.string   "body"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parent_comments", ["parent_id", "created_at"], name: "index_parent_comments_on_parent_id_and_created_at"

  create_table "parents", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.integer  "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "parents", ["email"], name: "index_parents_on_email", unique: true
  add_index "parents", ["remember_token"], name: "index_parents_on_remember_token"

  create_table "sports", force: true do |t|
    t.string   "name"
    t.date     "season_start"
    t.date     "season_end"
    t.string   "open_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_age"
    t.integer  "max_age"
    t.boolean  "coed"
  end

  create_table "team_children", force: true do |t|
    t.integer  "teamID"
    t.integer  "childID"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "coach"
    t.integer  "sport"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
