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

ActiveRecord::Schema.define(:version => 20130624012345) do

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "ancestry"
    t.integer  "provider_id"
    t.integer  "temperature", :default => 0
    t.boolean  "auto_temp",   :default => true
  end

  add_index "customers", ["ancestry"], :name => "index_customers_on_ancestry"
  add_index "customers", ["provider_id"], :name => "index_customers_on_provider_id"

  create_table "issues", :force => true do |t|
    t.text     "content"
    t.integer  "issueable_id"
    t.string   "issueable_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "temperature",    :default => 0
    t.boolean  "auto_temp",      :default => true
    t.integer  "measure_id"
  end

  add_index "issues", ["issueable_id", "issueable_type"], :name => "index_issues_on_issueable_id_and_issueable_type"
  add_index "issues", ["measure_id"], :name => "index_issues_on_measure_id"

  create_table "measures", :force => true do |t|
    t.string   "content"
    t.integer  "display_order"
    t.integer  "weight"
    t.integer  "provider_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "measures", ["provider_id"], :name => "index_measures_on_provider_id"

  create_table "partners", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "ancestry"
    t.integer  "provider_id"
    t.integer  "temperature", :default => 0
    t.boolean  "auto_temp",   :default => true
  end

  add_index "partners", ["ancestry"], :name => "index_partners_on_ancestry"
  add_index "partners", ["provider_id"], :name => "index_partners_on_provider_id"

  create_table "plans", :force => true do |t|
    t.string   "content"
    t.boolean  "complete",   :default => false
    t.integer  "contact_id"
    t.integer  "issue_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "plans", ["issue_id"], :name => "index_plans_on_issue_id"

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "provider_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
