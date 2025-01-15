class Person < ApplicationRecord

  has_many :movie_cast_members, foreign_key: :person_id
  has_many :movie_crew_members, foreign_key: :person_id

  validates :name, presence: true
  validates :tmdb_id, presence: true, uniqueness: true

end
