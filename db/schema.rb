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

ActiveRecord::Schema.define(:version => 20111130225442) do

  create_table "artists", :force => true do |t|
    t.text     "name"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mbid"
    t.string   "eventsHref"
    t.datetime "on_tour_until"
    t.integer  "status",        :default => 1
    t.string   "skid"
  end

  create_table "beta_signups", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "ip_address"
    t.float    "lat"
    t.float    "lng"
    t.integer  "region_id"
    t.integer  "city_id"
    t.boolean  "approved",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beta_signups_roles", :id => false, :force => true do |t|
    t.integer "beta_signup_id"
    t.integer "role_id"
  end

  create_table "cities", :force => true do |t|
    t.integer  "region_id"
    t.integer  "country_id"
    t.float    "lat"
    t.float    "lng"
    t.float    "b_box_north"
    t.float    "b_box_south"
    t.float    "b_box_east"
    t.float    "b_box_west"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pop"
    t.string   "venue_ids"
    t.integer  "status",      :default => 1
    t.integer  "geonamesid"
  end

  add_index "cities", ["country_id"], :name => "index_cities_on_country_id"
  add_index "cities", ["name"], :name => "index_cities_on_name"
  add_index "cities", ["pop"], :name => "index_cities_on_pop"
  add_index "cities", ["region_id"], :name => "index_cities_on_region_id"

  create_table "commissions", :force => true do |t|
    t.float   "commission"
    t.integer "user_id"
    t.integer "marketplace_id"
  end

  create_table "countries", :force => true do |t|
    t.string   "country_code"
    t.float    "b_box_north"
    t.float    "b_box_south"
    t.float    "b_box_east"
    t.float    "b_box_west"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",       :default => 1
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
    t.string   "fname"
    t.string   "lname"
    t.string   "invoice_ids"
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
    t.integer  "user_id"
    t.integer  "public",     :default => 1
    t.integer  "status",     :default => 1
    t.integer  "created_by"
  end

  add_index "events", ["artist_id"], :name => "index_events_on_artist_id"
  add_index "events", ["venue_id"], :name => "index_events_on_venue_id"

  create_table "invoices", :force => true do |t|
    t.string   "sale_ids"
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

  create_table "regions", :force => true do |t|
    t.integer  "country_id"
    t.float    "b_box_north"
    t.float    "b_box_south"
    t.float    "b_box_east"
    t.float    "b_box_west"
    t.string   "name"
    t.string   "region_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",      :default => 1
  end

  add_index "regions", ["country_id"], :name => "index_regions_on_country_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
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
    t.integer  "invoice_id"
    t.integer  "ticket_group_id"
    t.string   "paypal_payment_id"
  end

  create_table "ticket_groups", :force => true do |t|
    t.text    "section"
    t.text    "row"
    t.integer "quantity"
    t.integer "event_id"
    t.integer "sale_id"
  end

  add_index "ticket_groups", ["event_id"], :name => "index_ticket_groups_on_event_id"

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
    t.string   "seat_number"
    t.integer  "sale_id"
    t.integer  "user_id"
    t.float    "list"
  end

  add_index "tickets", ["artist_id"], :name => "index_tickets_on_artist_id"
  add_index "tickets", ["event_id"], :name => "index_tickets_on_event_id"
  add_index "tickets", ["user_id"], :name => "index_tickets_on_user_id"

  create_table "tours", :force => true do |t|
    t.integer  "artist_id"
    t.string   "event_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
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
    t.string   "role_ids"
    t.boolean  "complete",                              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "region_name"
    t.string   "city_name"
    t.string   "country_name"
    t.float    "latitude",       :default => 0.0
    t.float    "longitude"
    t.integer  "skid"
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "status",         :default => 1
    t.string   "capacity_notes"
    t.string   "address"
  end

  add_index "venues", ["city_id"], :name => "index_venues_on_city_id"
  add_index "venues", ["country_id"], :name => "index_venues_on_country_id"
  add_index "venues", ["region_id"], :name => "index_venues_on_region_id"

end
