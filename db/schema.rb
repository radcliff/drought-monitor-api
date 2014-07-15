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

ActiveRecord::Schema.define(version: 20140715100341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "counties", force: true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "boundary",   limit: {:srid=>4326, :type=>"multi_polygon"}
  end

  add_index "counties", ["boundary"], :name => "index_counties_on_boundary", :spatial => true
  add_index "counties", ["state_id"], :name => "index_counties_on_state_id"

  create_table "drought_shapes", force: true do |t|
    t.integer  "date"
    t.integer  "dm"
    t.integer  "county_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "shape",      limit: {:srid=>0, :type=>"geometry"}
    t.integer  "state_id"
  end

  add_index "drought_shapes", ["county_id"], :name => "index_drought_shapes_on_county_id"
  add_index "drought_shapes", ["shape"], :name => "index_drought_shapes_on_shape", :spatial => true
  add_index "drought_shapes", ["state_id"], :name => "index_drought_shapes_on_state_id"

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "boundary",   limit: {:srid=>4326, :type=>"multi_polygon"}
  end

  add_index "states", ["boundary"], :name => "index_states_on_boundary", :spatial => true
  add_index "states", ["name"], :name => "index_states_on_name"
  add_index "states", ["region_id"], :name => "index_states_on_region_id"

end
