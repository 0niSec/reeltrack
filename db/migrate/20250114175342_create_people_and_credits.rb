class CreatePeopleAndCredits < ActiveRecord::Migration[8.0]

  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :tmdb_id, null: false
      t.string :profile_url # Their photo
      t.index :tmdb_id, unique: true
      t.timestamps
    end

    create_table :movie_cast_members do |t|
      t.belongs_to :movie, null: false, foreign_key: true
      t.belongs_to :person, null: false, foreign_key: true
      t.string :character_name
      t.integer :order # For sorting by importance
      t.index [ :movie_id, :order ] # For retrieving ordered cast
      t.timestamps
    end

    create_table :movie_crew_members do |t|
      t.belongs_to :movie, null: false, foreign_key: true
      t.belongs_to :person, null: false, foreign_key: true
      t.string :job
      t.string :department
      t.timestamps
    end
  end

end
