class User < ApplicationRecord

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :watchlist_items
  has_many :watched_movies
  has_many :reviews

  has_one :profile, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 128, 128 ]
    attachable.variant :medium, resize_to_limit: [ 300, 300 ]
  end

  has_many :movies, through: :watchlist_items, source: :watchable, source_type: "Movie"
  has_many :shows, through: :watchlist_items, source: :watchable, source_type: "Show"

  after_create :create_profile

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :username, with: ->(e) { e.strip.downcase }

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: {
      with: /\A[a-zA-Z0-9]+\z/,
      message: "can only contain letters, numbers, and underscores"
    },
    length: { in: 3..20, message: "must be between 3 and 20 characters" }

    validates :avatar,
      attached: true,
      content_type: { with: [ :jpg, :jpeg, :png ], spoofing_protection: true },
      size: { less_than: 5.megabytes, message: "must be less than 5MB" },
      dimension: { width: { max: 800 }, height: { max: 800 }, message: "must be less than 800x800" }

end
