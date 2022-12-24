class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, presence: true, allow_blank: false
  validates :style, presence: true

  def to_s
    "#{name} by #{brewery.name}"
  end
end
