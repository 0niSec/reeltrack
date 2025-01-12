class Movie < ApplicationRecord

  validates :title, presence: true
  validates :release_year, presence: true
  validates :tmdb_id, presence: true, uniqueness: true

  has_many :watched_movies
  has_many :reviews
  has_many :watchers, through: :watched_movies, source: :user
  has_and_belongs_to_many :genres

  def average_rating
    watched_movies.where.not(rating: nil).average(:rating).to_f.round(1)
  end

  def ratings_count
    watched_movies.where.not(rating: nil).count
  end

  scope :highly_rated, -> {
    joins(:watched_movies).group(:id).having("AVG(watched_movies.rating) >= ?", 4.0)
  }

  scope :popular, -> {
    joins(:watched_movies).group(:id).order("COUNT(watched_movies.id) DESC")
  }

  scope :recently_released, -> {
    where("release_year >= ?", Date.current.year - 1)
  }

end
