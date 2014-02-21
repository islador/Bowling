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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140203231631) do

  create_table "games", :force => true do |t|
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.integer  "team"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "turn_order"
    t.integer  "start_turn"
  end

  create_table "score_cards", :force => true do |t|
    t.integer  "throw1"
    t.integer  "throw2"
    t.integer  "throw3"
    t.integer  "throw4"
    t.integer  "throw5"
    t.integer  "throw6"
    t.integer  "throw7"
    t.integer  "throw8"
    t.integer  "throw9"
    t.integer  "throw10"
    t.integer  "throw11"
    t.integer  "throw12"
    t.integer  "throw13"
    t.integer  "throw14"
    t.integer  "throw15"
    t.integer  "throw16"
    t.integer  "throw17"
    t.integer  "throw18"
    t.integer  "throw19"
    t.integer  "throw20"
    t.integer  "throw21"
    t.integer  "total"
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "frame_1"
    t.integer  "frame_2"
    t.integer  "frame_3"
    t.integer  "frame_4"
    t.integer  "frame_5"
    t.integer  "frame_6"
    t.integer  "frame_7"
    t.integer  "frame_8"
    t.integer  "frame_9"
    t.integer  "frame_10"
  end

end
