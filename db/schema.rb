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

ActiveRecord::Schema[8.0].define(version: 2025_01_16_002023) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tmdb_id"
    t.index ["tmdb_id"], name: "index_genres_on_tmdb_id", unique: true
  end

  create_table "genres_movies", id: false, force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "genre_id", null: false
  end

  create_table "movie_cast_members", force: :cascade do |t|
    t.string "movie_id"
    t.integer "person_id", null: false
    t.string "character_name"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id", "order"], name: "index_movie_cast_members_on_movie_id_and_order"
    t.index ["movie_id"], name: "index_movie_cast_members_on_movie_id"
    t.index ["person_id"], name: "index_movie_cast_members_on_person_id"
  end

  create_table "movie_crew_members", force: :cascade do |t|
    t.string "movie_id"
    t.integer "person_id", null: false
    t.string "job"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_crew_members_on_movie_id"
    t.index ["person_id"], name: "index_movie_crew_members_on_person_id"
  end

  create_table "movie_reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "movie_id"
    t.integer "watched_movie_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_reviews_on_movie_id"
    t.index ["user_id"], name: "index_movie_reviews_on_user_id"
    t.index ["watched_movie_id"], name: "index_movie_reviews_on_watched_movie_id"
  end

  create_table "movies", primary_key: "tmdb_id", id: :string, force: :cascade do |t|
    t.string "title"
    t.text "overview"
    t.string "poster_url"
    t.integer "runtime"
    t.decimal "tmdb_rating"
    t.integer "tmdb_votes_count"
    t.string "backdrop_url"
    t.integer "reviews_count", default: 0
    t.integer "ratings_count", default: 0
    t.decimal "average_rating", precision: 2, scale: 1, default: "0.0"
    t.integer "watchlist_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tagline"
    t.date "release_date"
    t.integer "likes_count", default: 0
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "tmdb_id", null: false
    t.string "profile_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tmdb_id"], name: "index_people_on_tmdb_id", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.text "bio"
    t.integer "age"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "favorite_movies"
    t.text "favorite_shows"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "watched_movies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "movie_id"
    t.decimal "rating", precision: 2, scale: 1
    t.date "watched_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "liked", default: false
    t.index ["movie_id"], name: "index_watched_movies_on_movie_id"
    t.index ["user_id"], name: "index_watched_movies_on_user_id"
  end

  create_table "watchlist_items", force: :cascade do |t|
    t.integer "user_id"
    t.string "watchable_type"
    t.integer "watchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_watchlist_items_on_user_id"
    t.index ["watchable_type", "watchable_id"], name: "index_watchlist_items_on_watchable"
  end

  create_table "watchlist_movies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_watchlist_movies_on_movie_id"
    t.index ["user_id"], name: "index_watchlist_movies_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "movie_cast_members", "movies", primary_key: "tmdb_id"
  add_foreign_key "movie_cast_members", "people"
  add_foreign_key "movie_crew_members", "movies", primary_key: "tmdb_id"
  add_foreign_key "movie_crew_members", "people"
  add_foreign_key "movie_reviews", "movies", primary_key: "tmdb_id"
  add_foreign_key "movie_reviews", "users"
  add_foreign_key "movie_reviews", "watched_movies"
  add_foreign_key "profiles", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "watched_movies", "movies", primary_key: "tmdb_id"
  add_foreign_key "watched_movies", "users"
  add_foreign_key "watchlist_movies", "movies", primary_key: "tmdb_id"
  add_foreign_key "watchlist_movies", "users"
end
