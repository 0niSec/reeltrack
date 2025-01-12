class CreateMovies < ActiveRecord::Migration[8.0]

  def change
    create_table :movies do |t|
      t.string :title
      t.integer :release_year
      t.text :overview
      t.string :poster_url
      t.integer :runtime
      t.string :tmdb_id
      t.decimal :tmdb_rating
      t.integer :tmdb_votes_count

      t.timestamps
    end
  end

end
