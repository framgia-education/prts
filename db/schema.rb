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

ActiveRecord::Schema.define(version: 20170705145230) do

  create_table "chatrooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "chatroom_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "offices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "pull_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url"
    t.integer  "status",           default: 0
    t.string   "repository_name"
    t.string   "github_account"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "current_reviewer"
    t.index ["github_account"], name: "index_pull_requests_on_github_account", using: :btree
    t.index ["status"], name: "index_pull_requests_on_status", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "role",             default: 0
    t.string   "provider"
    t.string   "token"
    t.string   "refresh_token"
    t.string   "chatwork_id"
    t.string   "chatwork_room_id"
    t.string   "github_account"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "oauth_token"
    t.integer  "office_id"
    t.index ["github_account"], name: "index_users_on_github_account", using: :btree
    t.index ["oauth_token"], name: "index_users_on_oauth_token", unique: true, using: :btree
    t.index ["office_id"], name: "index_users_on_office_id", using: :btree
  end

  create_table "white_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "github_account", limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_foreign_key "users", "offices"
end
