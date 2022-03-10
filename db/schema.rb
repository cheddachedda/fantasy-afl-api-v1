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

ActiveRecord::Schema[7.0].define(version: 2022_03_09_005744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.string "moniker"
    t.string "abbreviation"
  end

  create_table "fixtures", force: :cascade do |t|
    t.integer "round_no"
    t.datetime "datetime"
    t.string "venue"
    t.integer "home_id"
    t.integer "away_id"
    t.integer "home_goals_qt"
    t.integer "home_behinds_qt"
    t.integer "home_goals_ht"
    t.integer "home_behinds_ht"
    t.integer "home_goals_3qt"
    t.integer "home_behinds_3qt"
    t.integer "home_goals_ft"
    t.integer "home_behinds_ft"
    t.integer "away_goals_qt"
    t.integer "away_behinds_qt"
    t.integer "away_goals_ht"
    t.integer "away_behinds_ht"
    t.integer "away_goals_3qt"
    t.integer "away_behinds_3qt"
    t.integer "away_goals_ft"
    t.integer "away_behinds_ft"
  end

end
