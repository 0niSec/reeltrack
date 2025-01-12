class Review < ApplicationRecord

  belongs_to :user
  belongs_to :movie
  belongs_to :watched_movie

  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }
  validate :must_have_watched_movie

  private

  def must_have_watched_movie
    unless watched_movie.user_id == user_id && watched_movie.movie_id == movie_id
      errors.add(:base, "You must watch the movie before reviewing it")
    end
  end

end
