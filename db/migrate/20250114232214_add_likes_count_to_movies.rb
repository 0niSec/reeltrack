class AddLikesCountToMovies < ActiveRecord::Migration[8.0]

  def change
    add_column :movies, :likes_count, :integer, default: 0
  end

end
