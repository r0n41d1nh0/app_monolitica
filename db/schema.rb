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

ActiveRecord::Schema[8.0].define(version: 2025_07_28_023032) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "notification_requests", force: :cascade do |t|
    t.string "notification_template_key", null: false
    t.string "recipient", null: false
    t.string "channel", null: false
    t.string "status", null: false
    t.jsonb "provider_response"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_template_key"], name: "index_notification_requests_on_notification_template_key"
    t.index ["status"], name: "index_notification_requests_on_status"
  end

  create_table "notification_templates", force: :cascade do |t|
    t.string "key", null: false
    t.text "default_title"
    t.text "default_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_notification_templates_on_key", unique: true
  end

  add_foreign_key "notification_requests", "notification_templates", column: "notification_template_key", primary_key: "key"
end
