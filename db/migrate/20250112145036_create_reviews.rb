class CreateReviews < ActiveRecord::Migration[8.0]

  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.references :watched_movie, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end

end
