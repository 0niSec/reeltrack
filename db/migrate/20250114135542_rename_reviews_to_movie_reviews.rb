class RenameReviewsToMovieReviews < ActiveRecord::Migration[8.0]

  def change
    rename_table :reviews, :movie_reviews
  end

end
