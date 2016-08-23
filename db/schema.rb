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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141125225339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colors", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "r"
    t.integer  "g"
    t.integer  "b"
    t.float    "a"
  end

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "galleries", ["user_id"], name: "index_galleries_on_user_id", using: :btree

  create_table "palette_colors", force: :cascade do |t|
    t.integer  "palette_id"
    t.integer  "color_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "palette_colors", ["color_id"], name: "index_palette_colors_on_color_id", using: :btree
  add_index "palette_colors", ["palette_id"], name: "index_palette_colors_on_palette_id", using: :btree

  create_table "palettes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "user_id",    null: false
    t.boolean  "is_default"
  end

  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "gallery_id"
    t.string   "name"
  end

  add_index "pictures", ["gallery_id"], name: "index_pictures_on_gallery_id", using: :btree
  add_index "pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree

  create_table "snapshots", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "picture_id",          null: false
    t.integer  "cell_size",           null: false
    t.integer  "original_png_width",  null: false
    t.integer  "original_png_height", null: false
    t.binary   "original_png_blob",   null: false
    t.binary   "thumbnail_png_blob",  null: false
    t.binary   "display_png_blob",    null: false
  end

  add_index "snapshots", ["picture_id"], name: "index_snapshots_on_picture_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
