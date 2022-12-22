module RatingAverage
    extend ActiveSupport::Concern
    
    def average_rating
        (ratings.sum(:score) / ratings.size).to_f
    end

end