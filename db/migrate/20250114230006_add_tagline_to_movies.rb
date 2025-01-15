class AddTaglineToMovies < ActiveRecord::Migration[8.0]

  def change
    add_column :movies, :tagline, :string
  end

end
