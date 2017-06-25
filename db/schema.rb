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

ActiveRecord::Schema.define(version: 20170625032414) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.integer  "vote_state", default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "content"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "vote_count",  default: 0
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bookmarks", ["question_id"], name: "index_bookmarks_on_question_id", using: :btree
  add_index "bookmarks", ["user_id", "question_id"], name: "index_bookmarks_on_user_id_and_question_id", unique: true, using: :btree
  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id", using: :btree

  create_table "question_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "vote_state",  default: 0
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "user_id"
    t.integer  "vote_count",      default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "bookmarks_count", default: 0
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "uid",                    default: "", null: false
    t.string   "provider",               default: "", null: false
    t.string   "image_url"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar"
    t.integer  "reputation_count",       default: 1
    t.text     "profile"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "bookmarks", "questions"
  add_foreign_key "bookmarks", "users"
end
