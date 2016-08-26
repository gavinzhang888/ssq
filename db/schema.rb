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

ActiveRecord::Schema.define(version: 20160825131836) do

  create_table "api_v1_clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "remark"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "creator_id"
    t.datetime "deleted_at"
  end

  create_table "api_v1_opportunities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "client_id"
    t.decimal  "amount",     precision: 12, scale: 2
    t.string   "remark"
    t.integer  "status_id"
    t.integer  "creator_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "double_balls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "number"
    t.datetime "date"
    t.integer  "red_1"
    t.integer  "red_2"
    t.integer  "red_3"
    t.integer  "red_4"
    t.integer  "red_5"
    t.integer  "red_6"
    t.integer  "blue"
    t.integer  "all_count",                            default: 0
    t.decimal  "amount",      precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_1",                              default: 0
    t.decimal  "amount_1",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_2",                              default: 0
    t.decimal  "amount_2",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_3",                              default: 0
    t.decimal  "amount_3",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_4",                              default: 0
    t.decimal  "amount_4",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_5",                              default: 0
    t.decimal  "amount_5",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_6",                              default: 0
    t.decimal  "amount_6",    precision: 30, scale: 2, default: "0.0"
    t.integer  "odd",                                  default: 0
    t.integer  "prime",                                default: 0
    t.integer  "red_total",                            default: 0
    t.integer  "total",                                default: 0
    t.integer  "week_number"
    t.integer  "creator_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["creator_id"], name: "index_double_balls_on_creator_id", using: :btree
  end

  create_table "histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "historyable_type"
    t.integer  "historyable_id"
    t.integer  "user_id"
    t.string   "operation"
    t.text     "detail",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["historyable_id", "historyable_type"], name: "index_histories_on_historyable_id_and_historyable_type", using: :btree
    t.index ["user_id"], name: "index_histories_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "content",    limit: 65535
    t.string   "link"
    t.boolean  "readed",                   default: false
    t.integer  "category"
    t.integer  "creator_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "level",                    default: 0
    t.index ["creator_id"], name: "index_notifications_on_creator_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "prize_balls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "number"
    t.datetime "date"
    t.integer  "red_1"
    t.integer  "red_2"
    t.integer  "red_3"
    t.integer  "red_4"
    t.integer  "red_5"
    t.integer  "red_6"
    t.integer  "blue"
    t.integer  "all_count",                            default: 0
    t.decimal  "amount",      precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_1",                              default: 0
    t.decimal  "amount_1",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_2",                              default: 0
    t.decimal  "amount_2",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_3",                              default: 0
    t.decimal  "amount_3",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_4",                              default: 0
    t.decimal  "amount_4",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_5",                              default: 0
    t.decimal  "amount_5",    precision: 30, scale: 2, default: "0.0"
    t.integer  "grade_6",                              default: 0
    t.decimal  "amount_6",    precision: 30, scale: 2, default: "0.0"
    t.integer  "odd",                                  default: 0
    t.integer  "prime",                                default: 0
    t.integer  "red_total",                            default: 0
    t.integer  "total",                                default: 0
    t.integer  "week_number"
    t.integer  "creator_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["creator_id"], name: "index_prize_balls_on_creator_id", using: :btree
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "sort_num"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "detail",     limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "user_views", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "list_type"
    t.string   "name"
    t.boolean  "is_default",               default: false
    t.text     "detail",     limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["user_id"], name: "index_user_views_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "username",               default: "",    null: false
    t.boolean  "approved",               default: true,  null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "locale"
    t.string   "theme"
    t.boolean  "boxed",                  default: false
    t.boolean  "collapsed",              default: false
    t.boolean  "floated",                default: false
    t.boolean  "hovered",                default: false
    t.datetime "deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
