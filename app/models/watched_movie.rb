class WatchedMovie < ApplicationRecord

  belongs_to :user
  belongs_to :movie

  validates :user_id, uniqueness: { scope: :movie_id }
  validates :rating, numericality: {
    in: 0.5..5,
    allow_nil: true,
    message: "must be between 0.5 and 5"
  }
  validate :rating_must_be_half_or_whole

  before_save :ensure_watched_date

  private

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
