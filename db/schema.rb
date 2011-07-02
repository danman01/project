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

ActiveRecord::Schema.define(:version => 20110628162308) do

  create_table "artists", :force => true do |t|
    t.text     "name"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mbid"
    t.string   "eventsHref"
    t.datetime "on_tour_until"
  end

  create_table "customers", :force => true do |t|
    t.string   "email"
    t.string   "client_type"
    t.string   "street"
    t.string   "city"
    t.string   "region"
    t.string   "phone"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.text     "name"
    t.datetime "date"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
    t.integer  "venue_id"
    t.datetime "time"
  end

  create_table "invoices", :force => true do |t|
    t.string   "sales_ids"
    t.integer  "customer_id"
    t.integer  "total"
    t.integer  "user_id"
    t.integer  "on_site"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marketplaces", :force => true do |t|
    t.text     "name"
    t.float    "commission"
    t.text     "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.datetime "date"
    t.integer  "price"
    t.integer  "quantity"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticket_ids"
    t.integer  "marketplace_id"
    t.string   "order_id"
    t.integer  "shipping"
    t.string   "shipping_kind"
    t.integer  "handling"
    t.string   "invoice_id"
    t.integer  "ticket_group_id"
  end

  create_table "ticket_groups", :force => true do |t|
    t.text    "section"
    t.text    "row"
    t.integer "quantity"
    t.integer "event_id"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "cost"
    t.datetime "bought_on"
    t.datetime "in_hand"
    t.text     "kind"
    t.integer  "sold"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "artist_id"
    t.integer  "venue_id"
    t.integer  "ticket_group_id"
    t.integer  "seat_number"
    t.integer  "sale_id"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street"
    t.string   "city"
    t.string   "region"
    t.string   "country"
    t.string   "phone"
    t.string   "notes"
    t.string   "ticket_ids"
    t.string   "event_ids"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "state"
    t.string   "city"
    t.string   "region"
    t.string   "country"
    t.string   "latitude"
    t.string   "longitude"
  end

end
