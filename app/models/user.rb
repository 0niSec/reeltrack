class User < ApplicationRecord

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :watchlist_items
  has_many :watched_movies
  has_many :reviews

  # TODO: Add ratings

  has_one :profile, dependent: :destroy

  has_many :movies, through: :watchlist_items, source: :watchable, source_type: "Movie"
  has_many :shows, through: :watchlist_items, source: :watchable, source_type: "Show"

  after_create :create_profile

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :username, with: ->(e) { e.strip.downcase }

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false, message: "is already in use" },
    format: {
      with: /\A[a-zA-Z0-9]+\z/,
      message: "can only contain letters, numbers, and underscores"
    },
    length: { in: 3..20, message: "must be between 3 and 20 characters" }

  validates :email_address,
    presence: true,
    uniqueness: { case_sensitive: false, message: "is already in use" },
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" }

  def create_profile
    build_profile.save unless profile
  end

end
