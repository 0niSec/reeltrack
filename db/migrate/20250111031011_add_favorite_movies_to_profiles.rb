class AddFavoriteMoviesToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :favorite_movies, :text
  end
end
