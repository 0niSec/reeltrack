class Genre < ApplicationRecord

  has_and_belongs_to_many :movies

  def to_param
    name.downcase
  end

end
