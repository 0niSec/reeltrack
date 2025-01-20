class AddLikedToWatchedMovies < ActiveRecord::Migration[8.0]

  def change
    add_column :watched_movies, :liked, :boolean, default: false
  end

end
