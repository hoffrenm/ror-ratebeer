class WeatherApi
  def self.get_weather_in(city)
    coordinates = get_coords_by_location(city)

    lat = coordinates.first
    lon = coordinates.last

    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{key}&units=metric&mode=xml"

    response = HTTParty.get(url)
    parsed_response = response.parsed_response["current"]

    return {} if parsed_response["city"].nil?

    JSON.parse(parsed_response.to_json, object_class: OpenStruct)
  end

  def self.get_coords_by_location(location)
    url = "http://api.openweathermap.org/geo/1.0/direct?q=#{ERB::Util.url_encode(location)}&limit=1&appid=#{key}"

    response = HTTParty.get(url, format: :json)
    lat =  response.parsed_response[0]["lat"]
    lon =  response.parsed_response[0]["lon"]

    [lat, lon]
  end

  def self.key
    return nil if Rails.env.test?
    raise 'WEATHERMAP_APIKEY env variable not defined' if ENV['WEATHERMAP_APIKEY'].nil?

    ENV.fetch('WEATHERMAP_APIKEY')
  end
end
