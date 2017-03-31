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

ActiveRecord::Schema.define(version: 20170327111924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string   "asset"
    t.integer  "picturable_id"
    t.string   "picturable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["picturable_id", "picturable_type"], name: "index_images_on_picturable_id_and_picturable_type", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id",   null: false
    t.integer  "variant_id", null: false
    t.integer  "quantity"
    t.decimal  "price"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id", "variant_id"], name: "index_line_items_on_order_id_and_variant_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "state"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",           default: "",    null: false
    t.string   "description",    default: "",    null: false
    t.decimal  "price",          default: "0.0", null: false
    t.decimal  "discount_price"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "variants", force: :cascade do |t|
    t.string   "name"
    t.string   "sku",                            null: false
    t.integer  "count_on_hand",  default: 0
    t.string   "state"
    t.boolean  "visible",        default: false
    t.boolean  "is_default",     default: false
    t.integer  "product_id"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["imageable_type", "imageable_id"], name: "index_variants_on_imageable_type_and_imageable_id", using: :btree
    t.index ["product_id"], name: "index_variants_on_product_id", using: :btree
  end

end
