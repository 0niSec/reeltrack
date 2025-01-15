class AddTmdbIdToGenres < ActiveRecord::Migration[8.0]

  def change
    add_column :genres, :tmdb_id, :string
    add_index :genres, :tmdb_id, unique: true
  end

end
