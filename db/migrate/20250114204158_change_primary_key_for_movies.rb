class ChangePrimaryKeyForMovies < ActiveRecord::Migration[8.0]

  def change
    # First remove foreign key constraints
    remove_foreign_key :watched_movies, :movies
    remove_foreign_key :movie_cast_members, :movies
    remove_foreign_key :movie_crew_members, :movies
    remove_foreign_key :movie_reviews, :movies
    remove_foreign_key :watchlist_movies, :movies

    # Update foreign key columns to string type
    change_column :watched_movies, :movie_id, :string
    change_column :movie_cast_members, :movie_id, :string
    change_column :movie_crew_members, :movie_id, :string
    change_column :movie_reviews, :movie_id, :string
    change_column :watchlist_movies, :movie_id, :string

    # For SQLite, we need to recreate the table to change the primary key
    create_table :new_movies, id: false do |t|
      t.string :tmdb_id, primary_key: true
      t.string :title
      t.integer :release_year
      t.text :overview
      t.string :poster_url
      t.integer :runtime
      t.decimal :tmdb_rating
      t.integer :tmdb_votes_count
      t.string :backdrop_url
      t.integer :reviews_count, default: 0
      t.integer :ratings_count, default: 0
      t.decimal :average_rating, precision: 2, scale: 1, default: "0.0"
      t.integer :watchlist_count, default: 0
      t.timestamps
    end

    # Copy data from old table to new table
    execute "INSERT INTO new_movies SELECT tmdb_id, title, release_year, overview, poster_url, runtime, tmdb_rating, tmdb_votes_count, backdrop_url, reviews_count, ratings_count, average_rating, watchlist_count, created_at, updated_at FROM movies"

    # Drop old table and rename new table
    drop_table :movies
    rename_table :new_movies, :movies

    # Add back foreign key constraints
    add_foreign_key :watched_movies, :movies, column: :movie_id, primary_key: :tmdb_id
    add_foreign_key :movie_cast_members, :movies, column: :movie_id, primary_key: :tmdb_id
    add_foreign_key :movie_crew_members, :movies, column: :movie_id, primary_key: :tmdb_id
    add_foreign_key :movie_reviews, :movies, column: :movie_id, primary_key: :tmdb_id
    add_foreign_key :watchlist_movies, :movies, column: :movie_id, primary_key: :tmdb_id
  end

end
