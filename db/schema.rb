# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_09_080106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dns_servers", force: :cascade do |t|
    t.string "ip", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ip"], name: "index_dns_servers_on_ip", unique: true
  end

  create_table "hostnames", force: :cascade do |t|
    t.string "domain", null: false
    t.bigint "dns_server_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dns_server_id", "domain"], name: "index_hostnames_on_dns_server_id_and_domain", unique: true
    t.index ["dns_server_id"], name: "index_hostnames_on_dns_server_id"
    t.index ["domain"], name: "index_hostnames_on_domain"
  end

  add_foreign_key "hostnames", "dns_servers"
end
