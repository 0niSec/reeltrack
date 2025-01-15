class ChangeReleaseDateToString < ActiveRecord::Migration[8.0]

  def change
    change_column :movies, :release_date, :string
  end

end
