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

ActiveRecord::Schema.define(version: 2021_12_21_011047) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.string "announcement_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "published_at"
    t.string "show_site_wide"
    t.string "target"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_announcements_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "feed_url", null: false
    t.text "fetch_error"
    t.string "name"
    t.datetime "publish_date_last_sent_item"
    t.bigint "subscribe_form_id"
    t.integer "truncation"
    t.datetime "updated_at", null: false
    t.string "url"
    t.bigint "user_id"
    t.index ["subscribe_form_id"], name: "index_feeds_on_subscribe_form_id"
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.datetime "created_at"
    t.string "scope"
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "active_job_id"
    t.text "concurrency_key"
    t.datetime "created_at", precision: 6, null: false
    t.text "cron_key"
    t.text "error"
    t.datetime "finished_at"
    t.datetime "performed_at"
    t.integer "priority"
    t.text "queue_name"
    t.uuid "retried_good_job_id"
    t.datetime "scheduled_at"
    t.jsonb "serialized_params"
    t.datetime "updated_at", precision: 6, null: false
    t.index ["active_job_id", "created_at"], name: "index_good_jobs_on_active_job_id_and_created_at"
    t.index ["concurrency_key"], name: "index_good_jobs_on_concurrency_key_when_unfinished", where: "(finished_at IS NULL)"
    t.index ["cron_key", "created_at"], name: "index_good_jobs_on_cron_key_and_created_at"
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
  end

  create_table "sent_emails", force: :cascade do |t|
    t.float "compose_duration_in_seconds", default: 0.0
    t.datetime "created_at", null: false
    t.json "index"
    t.integer "number_of_items"
    t.string "receiver"
    t.string "subject"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_sent_emails_on_user_id"
  end

  create_table "service_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "data", null: false
    t.string "service_type", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "feed_url"
    t.string "name"
    t.bigint "subscribe_form_id"
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["subscribe_form_id"], name: "index_sites_on_subscribe_form_id"
  end

  create_table "subscribe_forms", force: :cascade do |t|
    t.string "color", default: ""
    t.datetime "created_at", null: false
    t.string "feed_url"
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", null: false
    t.string "url"
    t.bigint "user_id"
    t.index ["slug"], name: "index_subscribe_forms_on_slug"
    t.index ["user_id"], name: "index_subscribe_forms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.string "card_last4"
    t.string "card_type"
    t.jsonb "communication_settings"
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.inet "current_sign_in_ip"
    t.datetime "deleted_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "first_name"
    t.boolean "is_pro", default: false
    t.datetime "last_announcement_read_at"
    t.string "last_name"
    t.datetime "last_sign_in_at"
    t.inet "last_sign_in_ip"
    t.datetime "locked_at"
    t.jsonb "paddle_data", default: {}
    t.string "paddle_email", default: ""
    t.string "paddle_subscription_id", default: ""
    t.string "paddle_user_id", default: ""
    t.string "processor"
    t.string "processor_id"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "send_email_at", default: ""
    t.integer "sign_in_count", default: 0, null: false
    t.string "time_zone", default: "UTC"
    t.datetime "trial_ends_at"
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "unsubscribed_at"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "announcements", "users"
  add_foreign_key "feeds", "users"
  add_foreign_key "sites", "subscribe_forms"
end
