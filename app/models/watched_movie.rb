class WatchedMovie < ApplicationRecord

  belongs_to :user
  belongs_to :movie, primary_key: :tmdb_id
  has_many :movie_reviews, dependent: :destroy

  validates :user_id, uniqueness: { scope: :movie_id }
  validates :rating, numericality: {
    in: 0..5,
    allow_nil: true,
    message: "must be between 0 and 5"
  }
  validate :rating_must_be_half_or_whole

  before_save :ensure_watched_date

  after_save :update_movie_stats

  private

  def update_movie_stats
    new_average_rating = movie.watched_movies.where.not(rating: nil).average(:rating).to_f.round(1)
    new_likes_count = movie.watched_movies.where(liked: true).count
    new_ratings_count = movie.watched_movies.where.not(rating: nil).count

    movie.update_columns(average_rating: new_average_rating, ratings_count: new_ratings_count,
likes_count: new_likes_count)
  end

  def ensure_watched_date
    self.watched_date ||= Date.current
  end

  def rating_must_be_half_or_whole
    return if rating.nil?

    unless (rating * 2).to_i == rating * 2
      errors.add(:rating, "must be in increments of 0.5")
    end
  end

end
