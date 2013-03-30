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

ActiveRecord::Schema.define(:version => 20130330073611) do

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

  create_table "BUF", :id => false, :force => true do |t|
    t.datetime "DAT"
    t.string   "NAIM", :limit => 20
    t.decimal  "PLM",                :precision => 10, :scale => 3
    t.decimal  "PLS",                :precision => 10, :scale => 3
    t.decimal  "VRD",                :precision => 10, :scale => 3
    t.decimal  "VRS",                :precision => 10, :scale => 3
    t.decimal  "RLD",                :precision => 10, :scale => 3
    t.decimal  "OST",                :precision => 10, :scale => 3
    t.integer  "NSS"
  end

  create_table "BUF_NA", :id => false, :force => true do |t|
    t.integer "K_SW"
    t.string  "NAIM", :limit => 20
    t.integer "NP"
  end

  create_table "BUF_PL", :id => false, :force => true do |t|
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

  create_table "BUF_RL", :id => false, :force => true do |t|
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

  create_table "KC", :id => false, :force => true do |t|
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

  create_table "KS", :id => false, :force => true do |t|
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

  create_table "N_ASRT", :id => false, :force => true do |t|
    t.integer "K_SW"
    t.string  "NAIM", :limit => 20
    t.integer "NP"
  end

  create_table "PL", :id => false, :force => true do |t|
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

  create_table "RL", :id => false, :force => true do |t|
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

  create_table "TARX", :id => false, :force => true do |t|
    t.string   "DATA",   :limit => 8
    t.datetime "DAT"
    t.string   "RSUM",   :limit => 15
    t.decimal  "S",                     :precision => 15, :scale => 2
    t.string   "NAMEPO", :limit => 80
    t.string   "NAZN",   :limit => 252
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
