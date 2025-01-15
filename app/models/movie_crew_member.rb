class MovieCrewMember < ApplicationRecord

  belongs_to :movie, primary_key: :tmdb_id
  belongs_to :person

  validates :job, presence: true
  validates :department, presence: true

end
