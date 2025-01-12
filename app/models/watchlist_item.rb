class WatchlistItem < ApplicationRecord

  belongs_to :user
  belongs_to :watchable, polymorphic: true

  scope :recent, -> { order(created_at: :desc) }

end
