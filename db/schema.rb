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

ActiveRecord::Schema.define(version: 20161025120810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "login",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.index ["login"], name: "index_admins_on_login", unique: true, using: :btree
  end

  create_table "dispatchers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "active"
    t.index ["email"], name: "index_dispatchers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_dispatchers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "car_type"
    t.integer  "passengers",             default: 0
    t.integer  "trunk",                  default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "phone",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "active"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "status",                 default: "offline"
    t.integer  "done",                   default: 0
    t.integer  "cancelled",              default: 0
    t.index ["phone"], name: "index_drivers_on_phone", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_drivers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "order_drivers", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "phone"
    t.string   "start_point"
    t.string   "end_point"
    t.text     "comment"
    t.integer  "client_id"
    t.integer  "driver_id"
    t.integer  "dispatcher_id"
    t.integer  "passengers"
    t.boolean  "baggage"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "email"
    t.string   "status",        default: "new"
    t.string   "decline_order"
  end

  create_table "orders_blogs", force: :cascade do |t|
    t.string   "action"
    t.integer  "order_id"
    t.integer  "dispatcher_id"
    t.integer  "driver_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
