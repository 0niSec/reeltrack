class Movie < ApplicationRecord

  validates :title, presence: true
  validates :release_date, presence: true
  validates :tmdb_id, presence: true

  # Cast & Crew associations
  has_many :movie_cast_members
  has_many :movie_crew_members
  has_many :cast_members, through: :movie_cast_members, source: :cast_member
  has_many :crew_members, through: :movie_crew_members, source: :crew_member

  # Other associations
  has_many :watched_movies
  has_many :reviews, class_name: "MovieReview", foreign_key: :movie_id, primary_key: :tmdb_id
  has_many :watchers, through: :watched_movies, source: :user
  has_and_belongs_to_many :genres

  scope :search, ->(query) {
    where("LOWER(title) LIKE ? OR LOWER(overview) LIKE ?",
      "%#{query.downcase}%",
      "%#{query.downcase}%"
    ).order(release_date: :desc)
  }

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
    where("release_date >= ?", Date.current.year - 1)
  }

  def crew_by_department
    movie_crew_members.includes(:person).group_by(&:department)
  end


end
