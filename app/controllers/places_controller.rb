class PlacesController < ApplicationController
  def index
  end

  def show
    @location = BeermappingApi.get_location_data_by_id(params[:id])

    if @location.nil?
      redirect_to places_path, notice: 'Something went wrong'
    else
      render :show
    end
  end

  def search
    @places = BeermappingApi.places_in(params[:city])

    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      @weather = WeatherApi.get_weather_in(params[:city])
      render :index, status: 418
    end
  end
end
