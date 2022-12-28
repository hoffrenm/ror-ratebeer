module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.size.to_f
  end
end
