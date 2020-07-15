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

ActiveRecord::Schema.define(version: 20190825220617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "board_member_votes", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "board_member_id"
    t.integer  "vote_id"
    t.text     "dissent_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "board_member_votes", ["board_member_id"], name: "index_board_member_votes_on_board_member_id", using: :btree
  add_index "board_member_votes", ["case_id"], name: "index_board_member_votes_on_case_id", using: :btree
  add_index "board_member_votes", ["vote_id"], name: "index_board_member_votes_on_vote_id", using: :btree

  create_table "board_members", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "board_position"
    t.string   "job_title"
    t.string   "organization"
    t.string   "facebook_handle"
    t.string   "twitter_handle"
    t.string   "linkedin_handle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "case_rule_counts", force: :cascade do |t|
    t.integer  "case_rule_id"
    t.integer  "count_order"
    t.text     "content"
    t.boolean  "is_guilty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_rule_counts", ["case_rule_id"], name: "index_case_rule_counts_on_case_rule_id", using: :btree

  create_table "case_rules", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "rule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rule_order"
  end

  add_index "case_rules", ["case_id"], name: "index_case_rules_on_case_id", using: :btree
  add_index "case_rules", ["rule_id"], name: "index_case_rules_on_rule_id", using: :btree

  create_table "case_text_files", force: :cascade do |t|
    t.integer  "case_id"
    t.string   "name"
    t.text     "search_text"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cases", force: :cascade do |t|
    t.string   "number"
    t.integer  "defendant_id"
    t.date     "date_initiated"
    t.date     "date_decided"
    t.integer  "recommended_outcome_id"
    t.integer  "decided_outcome_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "files"
    t.boolean  "is_active"
    t.text     "majority_decision"
    t.boolean  "is_open"
    t.integer  "category"
    t.boolean  "appealed",               default: false
  end

  add_index "cases", ["decided_outcome_id"], name: "index_cases_on_decided_outcome_id", using: :btree
  add_index "cases", ["defendant_id"], name: "index_cases_on_defendant_id", using: :btree
  add_index "cases", ["recommended_outcome_id"], name: "index_cases_on_recommended_outcome_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "authority_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["authority_id"], name: "index_categories_on_authority_id", using: :btree

  create_table "complaints", force: :cascade do |t|
    t.string   "number"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaints", ["case_id"], name: "index_complaints_on_case_id", using: :btree

  create_table "defendants", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank_id"
  end

  add_index "defendants", ["rank_id"], name: "index_defendants_on_rank_id", using: :btree

  create_table "minority_opinions", force: :cascade do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "opinion_text"
    t.integer  "case_id"
    t.integer  "board_member_one_id"
    t.integer  "board_member_two_id"
    t.integer  "board_member_three_id"
    t.integer  "board_member_four_id"
    t.integer  "number_of_votes"
  end

  add_index "minority_opinions", ["board_member_four_id"], name: "index_minority_opinions_on_board_member_four_id", using: :btree
  add_index "minority_opinions", ["board_member_one_id"], name: "index_minority_opinions_on_board_member_one_id", using: :btree
  add_index "minority_opinions", ["board_member_three_id"], name: "index_minority_opinions_on_board_member_three_id", using: :btree
  add_index "minority_opinions", ["board_member_two_id"], name: "index_minority_opinions_on_board_member_two_id", using: :btree

  create_table "outcomes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_civilian"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", force: :cascade do |t|
    t.integer  "code"
    t.text     "description"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: :cascade do |t|
    t.date     "start"
    t.date     "end"
    t.integer  "board_member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "terms", ["board_member_id"], name: "index_terms_on_board_member_id", using: :btree

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
