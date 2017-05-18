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

ActiveRecord::Schema.define(version: 20170518153133) do

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pull_requests", force: :cascade do |t|
    t.string   "url"
    t.integer  "status",     default: 0
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["project_id"], name: "index_pull_requests_on_project_id"
    t.index ["user_id"], name: "index_pull_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "first_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "stage",            default: 0
    t.boolean  "is_admin"
    t.string   "provider"
    t.string   "token"
    t.string   "refresh_token"
    t.string   "chatwork_id"
    t.string   "chatwork_room_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end
