class MovieCastMember < ApplicationRecord

  belongs_to :movie, primary_key: :tmdb_id
  belongs_to :person

  validates :character_name, presence: true
  validates :order, presence: true, numericality: { only_integer: true, greater_than: 0 }

end
