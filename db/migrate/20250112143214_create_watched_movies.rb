class CreateWatchedMovies < ActiveRecord::Migration[8.0]

  def change
    create_table :watched_movies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.decimal :rating
      t.date :watched_date

      t.timestamps
    end
  end

end
