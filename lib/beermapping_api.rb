class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.weeks) { get_places_in(city) }
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.get_location_data_by_id(loc_id)
    url = "http://beermapping.com/webservice/locquery/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(loc_id)}"
    location = response.parsed_response["bmp_locations"]["location"]

    Place.new(location)
  end

  def self.key
    return nil if Rails.env.test?
    raise 'BEERMAPPING_APIKEY env variable not defined' if ENV['BEERMAPPING_APIKEY'].nil?

    ENV.fetch('BEERMAPPING_APIKEY')
  end
end
