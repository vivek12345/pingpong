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

ActiveRecord::Schema.define(:version => 20150215221351) do

  create_table "championship_players", :force => true do |t|
    t.integer  "championship_id"
    t.integer  "player_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "championships", :force => true do |t|
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "championship_id"
    t.integer  "level"
    t.integer  "player1"
    t.integer  "player2"
    t.string   "status"
    t.integer  "winner"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "matches", :force => true do |t|
    t.integer  "game_id"
    t.integer  "playing_first"
    t.integer  "playing_second"
    t.integer  "first_player_move"
    t.integer  "second_player_move"
    t.integer  "winner"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "role"
    t.integer  "defence_set_length"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
