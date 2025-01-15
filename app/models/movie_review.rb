class MovieReview < ApplicationRecord

  belongs_to :movie, primary_key: :tmdb_id
  belongs_to :user
  belongs_to :watched_movie

  validates :content, presence: true

end
