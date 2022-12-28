class Beer < ApplicationRecord
  extend TopRatings
  include RatingAverage

  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, presence: true, allow_blank: false
  validates :style, presence: true

  def to_s
    name.to_s
  end
end
