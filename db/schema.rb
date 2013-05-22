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

ActiveRecord::Schema.define(:version => 20130522193947) do

  create_table "ASRT", :id => false, :force => true do |t|
    t.integer  "K_SW"
    t.integer  "NN"
    t.string   "S",      :limit => 1
    t.datetime "DAT"
    t.integer  "N"
    t.integer  "NP"
    t.string   "N_NAIM", :limit => 20
    t.string   "NAIM",   :limit => 20
    t.decimal  "VES",                  :precision => 5, :scale => 2
    t.decimal  "VRS",                  :precision => 7, :scale => 3
    t.decimal  "VRD",                  :precision => 7, :scale => 3
    t.decimal  "RLS",                  :precision => 7, :scale => 3
    t.decimal  "RLD",                  :precision => 7, :scale => 3
    t.decimal  "RSX",                  :precision => 7, :scale => 3
    t.decimal  "OST",                  :precision => 7, :scale => 3
    t.decimal  "VRN",                  :precision => 7, :scale => 3
    t.string   "AWT",    :limit => 1
    t.decimal  "APR",                  :precision => 7, :scale => 3
    t.decimal  "ARS",                  :precision => 7, :scale => 3
    t.decimal  "OSV",                  :precision => 7, :scale => 3
  end

  create_table "KC", :force => true do |t|
    t.integer  "N"
    t.datetime "DAT"
    t.string   "KOD",  :limit => 2
    t.string   "NAIM", :limit => 20
    t.decimal  "SUM",                :precision => 8, :scale => 2
    t.decimal  "BN1",                :precision => 8, :scale => 2
    t.decimal  "BN2",                :precision => 8, :scale => 2
    t.decimal  "BN3",                :precision => 8, :scale => 2
    t.decimal  "BN4",                :precision => 8, :scale => 2
    t.decimal  "BN5",                :precision => 8, :scale => 2
    t.string   "BK1",  :limit => 9
    t.string   "BK2",  :limit => 9
    t.string   "BK3",  :limit => 9
    t.string   "BK4",  :limit => 9
    t.string   "BK5",  :limit => 9
    t.string   "AWT",  :limit => 1
  end

  create_table "KS", :force => true do |t|
    t.integer  "N"
    t.datetime "DAT"
    t.string   "KOD",  :limit => 2
    t.string   "NAIM", :limit => 20
    t.decimal  "SUM",                :precision => 8, :scale => 2
    t.decimal  "BN1",                :precision => 8, :scale => 2
    t.decimal  "BN2",                :precision => 8, :scale => 2
    t.decimal  "BN3",                :precision => 8, :scale => 2
    t.decimal  "BN4",                :precision => 8, :scale => 2
    t.decimal  "BN5",                :precision => 8, :scale => 2
    t.string   "AWT",  :limit => 1
    t.string   "BK1",  :limit => 9
    t.string   "BK2",  :limit => 9
    t.string   "BK3",  :limit => 9
    t.string   "BK4",  :limit => 9
    t.string   "BK5",  :limit => 9
  end

  create_table "N_ASRT", :force => true do |t|
    t.integer "K_SW"
    t.string  "NAIM", :limit => 20
    t.integer "NP"
  end

  create_table "PL", :force => true do |t|
    t.string   "C",    :limit => 1
    t.datetime "DAT"
    t.integer  "N"
    t.string   "KOD",  :limit => 4
    t.string   "NAIM", :limit => 20
    t.integer  "DN"
    t.decimal  "PLM",                :precision => 10, :scale => 3
    t.decimal  "PLS",                :precision => 10, :scale => 3
    t.decimal  "PLD",                :precision => 10, :scale => 3
    t.decimal  "VRY",                :precision => 10, :scale => 3
    t.decimal  "VRS",                :precision => 10, :scale => 3
    t.decimal  "VRD",                :precision => 10, :scale => 3
    t.decimal  "OST",                :precision => 10, :scale => 3
    t.decimal  "OST1",               :precision => 10, :scale => 3
    t.decimal  "RLD",                :precision => 10, :scale => 3
    t.integer  "NSS"
    t.string   "A1",   :limit => 1
    t.string   "A2",   :limit => 1
    t.string   "A3",   :limit => 1
    t.string   "A4",   :limit => 1
    t.string   "A5",   :limit => 1
    t.string   "A6",   :limit => 1
    t.string   "A7",   :limit => 1
    t.string   "A8",   :limit => 1
    t.string   "A9",   :limit => 1
    t.string   "P",    :limit => 1
    t.string   "AWT",  :limit => 1
  end

  create_table "RL", :force => true do |t|
    t.string   "S",    :limit => 1
    t.integer  "N"
    t.datetime "DAT"
    t.integer  "DN"
    t.string   "KOD",  :limit => 2
    t.string   "NAIM", :limit => 30
    t.integer  "SUM"
    t.integer  "SUMM"
    t.integer  "SUMY"
    t.string   "P",    :limit => 1
    t.string   "AWT",  :limit => 1
  end

  create_table "TARX", :force => true do |t|
    t.string   "DATA",   :limit => 8
    t.datetime "DAT"
    t.string   "RSUM",   :limit => 15
    t.decimal  "S",                     :precision => 15, :scale => 2
    t.string   "NAMEPO", :limit => 80
    t.string   "NAZN",   :limit => 252
  end

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_mains", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "plan_admin",             :default => false
    t.boolean  "super_admin",            :default => false
    t.boolean  "cash_admin",             :default => false
    t.boolean  "implementation_admin",   :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "assortments", :force => true do |t|
    t.string   "name"
    t.integer  "old_id"
    t.integer  "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cash_files", :force => true do |t|
    t.string   "cash_file_name"
    t.string   "cash_content_type"
    t.integer  "cash_file_size"
    t.datetime "cash_updated_at"
    t.string   "cashc_file_name"
    t.string   "cashc_content_type"
    t.integer  "cashc_file_size"
    t.datetime "cashc_updated_at"
    t.string   "balance_file_name"
    t.string   "balance_content_type"
    t.integer  "balance_file_size"
    t.datetime "balance_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "dbf_files", :force => true do |t|
    t.string   "plan_file_name"
    t.string   "plan_content_type"
    t.integer  "plan_file_size"
    t.datetime "plan_updated_at"
    t.string   "implementation_file_name"
    t.string   "implementation_content_type"
    t.integer  "implementation_file_size"
    t.datetime "implementation_updated_at"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "directions", :force => true do |t|
    t.string   "name"
    t.integer  "old_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "plans", :force => true do |t|
    t.float    "day"
    t.float    "month"
    t.date     "date"
    t.integer  "assortment_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "plans", ["assortment_id"], :name => "index_plans_on_assortment_id"

  create_table "quantities", :force => true do |t|
    t.integer  "kol"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
