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
end
