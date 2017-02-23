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

ActiveRecord::Schema.define(:version => 20170222075537) do

  create_table "temp", :id => false, :force => true do |t|
    t.string  "first_name",    :limit => nil
    t.string  "last_name",     :limit => nil
    t.string  "email",         :limit => nil
    t.string  "family_invite", :limit => nil
    t.string  "invitation_to", :limit => nil
    t.string  "address_line1", :limit => nil
    t.string  "address_line2", :limit => nil
    t.string  "city",          :limit => nil
    t.string  "state",         :limit => nil
    t.string  "zipcode",       :limit => nil
    t.integer "type"
    t.integer "tier"
    t.string  "code",          :limit => nil
  end

  create_table "user_groups", :force => true do |t|
    t.string   "code"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tier"
    t.string   "lodging_friday"
    t.string   "lodging_saturday"
    t.string   "lodging_sunday"
    t.string   "family_invite"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "is_attending"
    t.integer  "relationship"
    t.integer  "user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.string   "diet"
  end

end
