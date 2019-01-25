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

ActiveRecord::Schema.define(version: 2013_12_31_143527) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.string "text"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "followers", force: :cascade do |t|
    t.integer "followed_user_id"
    t.integer "following_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_user_id", "following_user_id"], name: "index_followers_on_followed_user_id_and_following_user_id", unique: true
    t.index ["followed_user_id"], name: "index_followers_on_followed_user_id"
    t.index ["following_user_id"], name: "index_followers_on_following_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.binary "image_data"
    t.text "description"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_name"
    t.string "file_type"
    t.index ["post_id"], name: "index_images_on_post_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.binary "avatar_image"
    t.text "personal_description"
    t.integer "user_id"
    t.string "file_name"
    t.string "file_type"
    t.index ["user_id"], name: "index_user_infos_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "screenname"
    t.string "locale"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
