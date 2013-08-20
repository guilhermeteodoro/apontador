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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130820123449) do

  create_table "checkings", :force => true do |t|
    t.datetime "checked_in_at"
    t.datetime "checked_out_at"
    t.decimal  "hour_value",     :precision => 10, :scale => 2
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
    t.decimal  "value",          :precision => 10, :scale => 2
    t.boolean  "approved"
    t.boolean  "paid",                                          :default => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "cnpj"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "companies", ["id"], :name => "index_companies_on_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "street"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "phone"
    t.string   "type"
    t.boolean  "manager"
    t.integer  "company_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "number"
    t.string   "username"
    t.decimal  "hour_value", :precision => 10, :scale => 2
  end

  add_index "users", ["id"], :name => "index_users_on_id"

end
