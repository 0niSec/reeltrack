class ChangeReleaseDateToDateInMovies < ActiveRecord::Migration[8.0]

  def change
    change_column :movies, :release_date, :date
  end

end