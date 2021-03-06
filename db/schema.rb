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

ActiveRecord::Schema.define(:version => 20110607014923) do

  create_table "administration_configurations", :force => true do |t|
    t.integer  "key"
    t.string   "value"
    t.string   "key_group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administration_user_hierachies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "helper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administration_user_roles", :force => true do |t|
    t.string   "rol"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administration_users", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "crypted_password"
    t.string   "email"
    t.integer  "role_id"
    t.integer  "ubication_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "role"
  end

  create_table "budgets_budget_supplies", :force => true do |t|
    t.integer  "type_supply"
    t.integer  "budget_id"
    t.string   "description"
    t.decimal  "unit_cost",    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "quantity",     :precision => 10, :scale => 2, :default => 0.0
    t.string   "unit_measure",                                :default => "0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budgets_budgets", :force => true do |t|
    t.integer  "support_request_id"
    t.integer  "supplier_id"
    t.decimal  "total_cost",         :precision => 10, :scale => 2, :default => 0.0
    t.date     "budget_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "budget_type"
    t.date     "ending_date"
    t.string   "order_num"
    t.integer  "status_id"
    t.decimal  "unit_cost",          :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "quantity",           :precision => 10, :scale => 2, :default => 0.0
    t.string   "unit_measure"
  end

  create_table "catalogs_comment_types", :force => true do |t|
    t.string   "abbr"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_priorities", :force => true do |t|
    t.string   "abbr"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_request_statuses", :force => true do |t|
    t.string   "abbr"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_suppliers", :force => true do |t|
    t.string   "abbr"
    t.string   "trade_name"
    t.string   "contact_name"
    t.string   "address"
    t.string   "mobile_phone"
    t.string   "business_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
    t.string   "taxpayer_reg"
    t.string   "postal_code"
    t.integer  "taxpayer_type"
  end

  create_table "catalogs_supplies", :force => true do |t|
    t.string   "abbr"
    t.string   "description"
    t.decimal  "unit_cost",    :precision => 10, :scale => 2, :default => 0.0
    t.string   "unit_measure"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_supply"
  end

  create_table "catalogs_support_types", :force => true do |t|
    t.string   "abbr"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_ubications", :force => true do |t|
    t.string   "abbr"
    t.string   "name"
    t.string   "responsible"
    t.string   "tel_ext"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "available"
  end

  create_table "catalogs_units", :force => true do |t|
    t.string   "abbr"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_workmanships", :force => true do |t|
    t.string   "abbr"
    t.string   "description"
    t.decimal  "unit_cost",    :precision => 10, :scale => 2, :default => 0.0
    t.string   "unit_measure"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_commentaries", :force => true do |t|
    t.integer  "support_request_id"
    t.integer  "user_id"
    t.text     "commentaries"
    t.integer  "comment_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "budget_id"
  end

  create_table "request_delegations", :force => true do |t|
    t.integer  "support_request_id"
    t.integer  "user_id"
    t.integer  "helper_id"
    t.integer  "notify"
    t.integer  "priority_id"
    t.integer  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_support_requests", :force => true do |t|
    t.integer  "request_no"
    t.integer  "ubication_id"
    t.integer  "helper_id"
    t.integer  "support_type_id"
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.text     "tech_description"
    t.date     "status_chng_date"
    t.integer  "request_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
