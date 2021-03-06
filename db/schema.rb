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

ActiveRecord::Schema.define(:version => 20120626065044) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposits", :force => true do |t|
    t.integer  "user_id"
    t.string   "paycheck_amount"
    t.string   "paycheck_frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foursquare_pushes", :force => true do |t|
    t.string   "push_id"
    t.string   "push_created_at"
    t.string   "push_type"
    t.string   "push_time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foursquare_users", :force => true do |t|
    t.string   "foursquare_user_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "photo"
    t.string   "gender"
    t.string   "home_city"
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "foursquare_push_id"
  end

  create_table "foursquare_venues", :force => true do |t|
    t.string   "venue_id"
    t.string   "venue_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "foursquare_push_id"
  end

  create_table "payees", :force => true do |t|
    t.string   "name",           :null => false
    t.integer  "user_id",        :null => false
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "name_on_bill"
    t.string   "account_number"
    t.string   "nick_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "payee_id",           :null => false
    t.string   "delivery_time"
    t.string   "amount"
    t.string   "number_of_payments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "amount"
    t.integer  "payable_id"
    t.string   "payable_type"
    t.string   "reference_number"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",                                           :null => false
    t.string   "last_name"
    t.string   "email",                                                :null => false
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.date     "birth_date"
    t.boolean  "gender"
    t.boolean  "active",                            :default => false, :null => false
    t.string   "crypted_password",                                     :null => false
    t.string   "password_salt",                                        :null => false
    t.string   "persistence_token",                                    :null => false
    t.string   "single_access_token",                                  :null => false
    t.string   "perishable_token",                  :default => "",    :null => false
    t.integer  "login_count",                       :default => 0,     :null => false
    t.integer  "failed_login_count",                :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secondry_email"
    t.string   "mobile"
    t.string   "email_delivery_time"
    t.string   "sms_delivery_time"
    t.boolean  "email_alert"
    t.boolean  "mobile_alert"
    t.string   "role",                :limit => 32
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

end
