module TopRatings
  def top(amount)
    sorted_by_rating_in_desc_order = all.sort_by{ |r| -r.average_rating }
    sorted_by_rating_in_desc_order.first(amount)
  end
end
