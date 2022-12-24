class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true, allow_blank: false
  validates :year, numericality: { greater_than_or_equal_to: 1040, less_than_or_equal_to: 2022 }
end
