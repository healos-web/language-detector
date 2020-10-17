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

ActiveRecord::Schema.define(version: 2020_10_15_185801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "distances", force: :cascade do |t|
    t.bigint "first_file_id"
    t.bigint "second_file_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_file_id"], name: "index_distances_on_first_file_id"
    t.index ["second_file_id"], name: "index_distances_on_second_file_id"
  end

  create_table "html_files", force: :cascade do |t|
    t.string "language"
    t.string "uuid"
    t.boolean "standart"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "alphabet"
    t.index ["uuid"], name: "index_html_files_on_uuid"
  end

  create_table "ngrams", force: :cascade do |t|
    t.integer "frequency"
    t.string "gram"
    t.bigint "html_file_id"
    t.index ["frequency"], name: "index_ngrams_on_frequency"
    t.index ["gram"], name: "index_ngrams_on_gram"
    t.index ["html_file_id"], name: "index_ngrams_on_html_file_id"
  end

  add_foreign_key "ngrams", "html_files"
end
