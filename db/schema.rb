# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_02_180806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authorities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "board_member_votes", id: :serial, force: :cascade do |t|
    t.integer "case_id"
    t.integer "board_member_id"
    t.integer "vote_id"
    t.text "dissent_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["board_member_id"], name: "index_board_member_votes_on_board_member_id"
    t.index ["case_id"], name: "index_board_member_votes_on_case_id"
    t.index ["vote_id"], name: "index_board_member_votes_on_vote_id"
  end

  create_table "board_members", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "board_position"
    t.string "job_title"
    t.string "organization"
    t.string "facebook_handle"
    t.string "twitter_handle"
    t.string "linkedin_handle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image"
  end

  create_table "case_rule_counts", id: :serial, force: :cascade do |t|
    t.integer "case_rule_id"
    t.integer "count_order"
    t.boolean "is_guilty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["case_rule_id"], name: "index_case_rule_counts_on_case_rule_id"
  end

  create_table "case_rules", id: :serial, force: :cascade do |t|
    t.integer "case_id"
    t.integer "rule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "rule_order"
    t.index ["case_id"], name: "index_case_rules_on_case_id"
    t.index ["rule_id"], name: "index_case_rules_on_rule_id"
  end

  create_table "cases", id: :serial, force: :cascade do |t|
    t.string "number"
    t.integer "defendant_id"
    t.date "date_initiated"
    t.date "date_decided"
    t.integer "recommended_outcome_id"
    t.integer "decided_outcome_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json "files"
    t.boolean "is_active"
    t.text "majority_decision"
    t.boolean "is_open"
    t.integer "category"
    t.boolean "appealed", default: false
    t.string "investigated_by"
    t.index ["decided_outcome_id"], name: "index_cases_on_decided_outcome_id"
    t.index ["defendant_id"], name: "index_cases_on_defendant_id"
    t.index ["recommended_outcome_id"], name: "index_cases_on_recommended_outcome_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "authority_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["authority_id"], name: "index_categories_on_authority_id"
  end

  create_table "complaints", id: :serial, force: :cascade do |t|
    t.string "number"
    t.integer "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["case_id"], name: "index_complaints_on_case_id"
  end

  create_table "defendants", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "rank_id"
    t.index ["rank_id"], name: "index_defendants_on_rank_id"
  end

  create_table "minority_opinions", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "opinion_text"
    t.integer "case_id"
    t.integer "board_member_one_id"
    t.integer "board_member_two_id"
    t.integer "board_member_three_id"
    t.integer "board_member_four_id"
    t.integer "number_of_votes"
    t.index ["board_member_four_id"], name: "index_minority_opinions_on_board_member_four_id"
    t.index ["board_member_one_id"], name: "index_minority_opinions_on_board_member_one_id"
    t.index ["board_member_three_id"], name: "index_minority_opinions_on_board_member_three_id"
    t.index ["board_member_two_id"], name: "index_minority_opinions_on_board_member_two_id"
  end

  create_table "outcomes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "is_civilian"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", id: :serial, force: :cascade do |t|
    t.integer "code"
    t.text "description"
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "superintendents", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "start_of_term"
    t.date "end_of_term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", id: :serial, force: :cascade do |t|
    t.date "start"
    t.date "end"
    t.integer "board_member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["board_member_id"], name: "index_terms_on_board_member_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
