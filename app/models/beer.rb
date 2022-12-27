class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, presence: true, allow_blank: false
  validates :style, presence: true

  def to_s
    name.to_s
  end

  def self.top(amount)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -b.average_rating }
    sorted_by_rating_in_desc_order.first(amount)
  end
end
