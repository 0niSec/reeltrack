class UpdateMoviesTable < ActiveRecord::Migration[8.0]

  def change
    change_table :movies do |t|
      # Add new columns
      t.string :backdrop_url
      t.integer :reviews_count, default: 0
      t.integer :ratings_count, default: 0
      t.decimal :average_rating, precision: 2, scale: 1, default: 0.0
      t.integer :watchlist_count, default: 0

      # Add new indexes
      t.index :tmdb_id, unique: true
      t.index :release_year
      t.index :average_rating
    end

    # Make tmdb_id required
    change_column_null :movies, :tmdb_id, false
  end

end
