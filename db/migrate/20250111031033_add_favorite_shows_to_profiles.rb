class AddFavoriteShowsToProfiles < ActiveRecord::Migration[8.0]

  def change
    add_column :profiles, :favorite_shows, :text
  end

end
