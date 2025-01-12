class ChangeRatingScaleInWatchedMovies < ActiveRecord::Migration[7.1]

  def change
    change_column :watched_movies, :rating, :decimal, precision: 2, scale: 1
  end

end
