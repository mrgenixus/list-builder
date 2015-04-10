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

ActiveRecord::Schema.define(version: 20150409221647) do

  create_table "lists", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "list_id"
    t.string  "person_email"
  end

  add_index "memberships", ["list_id"], name: "index_memberships_on_list_id"

  create_table "notes", force: :cascade do |t|
    t.text    "content"
    t.integer "membership_id"
  end

  add_index "notes", ["membership_id"], name: "index_notes_on_membership_id"

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end