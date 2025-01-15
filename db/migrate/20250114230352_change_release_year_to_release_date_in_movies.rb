class ChangeReleaseYearToReleaseDateInMovies < ActiveRecord::Migration[8.0]

  def change
    remove_column :movies, :release_year
    add_column :movies, :release_date, :date
  end

end
