class MovieReview < ApplicationRecord

  belongs_to :movie, primary_key: :tmdb_id
  belongs_to :user
  belongs_to :watched_movie

  validates :user_id, uniqueness: { scope: :movie_id }

  after_create :broadcast_review

  private

  def broadcast_review
    Rails.logger.info("Broadcasting review: #{self.inspect}")
    broadcast_append_to(
      [ movie, "movie_reviews" ],
      target: "movie_reviews",
      partial: "shared/review",
      locals: { review: self }
    )
  end

end
