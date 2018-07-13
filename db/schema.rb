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

ActiveRecord::Schema.define(version: 20180713012649) do

  create_table "experiments", force: :cascade do |t|
    t.text     "parameters"
    t.integer  "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "scores"
    t.index ["model_id", "created_at"], name: "index_experiments_on_model_id_and_created_at"
    t.index ["model_id"], name: "index_experiments_on_model_id"
  end

  create_table "models", force: :cascade do |t|
    t.string   "name"
    t.text     "comment"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "created_at"], name: "index_models_on_project_id_and_created_at"
    t.index ["project_id"], name: "index_models_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
