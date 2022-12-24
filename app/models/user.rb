class User < ApplicationRecord
  PASSWORD_REQUIREMENTS = /\A
    (?=.{4,})
    (?=.*[A-Z])
    (?=.*\d)
  /x

  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :clubs, through: :memberships, source: :beer_club

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates :password, presence: true, format: { with: PASSWORD_REQUIREMENTS }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.joins(:beer).group(:style).average(:score).max_by{ |_k, v| v }.first
  end

  def favorite_brewery
    return nil if ratings.empty?

    ratings.joins(beer: :brewery).group('breweries.name').average(:score).max_by{ |_k, v| v }.first
  end
end
