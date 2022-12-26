require 'rails_helper'

describe "Places" do
  it "if none is returned by the API, user is informed that no places exists" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
    expect(page).not_to have_content "Current weather"
  end

  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )
    allow(WeatherApi).to receive(:get_weather_in).with("kumpula").and_return(
      JSON.parse(weather_hash.to_json, object_class: OpenStruct)
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Current weather in Kumpula"
    expect(page).to have_content "Temperature: 21.9 celsius"
    expect(page).to have_content "Wind: 3.7 m/s, Direction: SouthEast"
  end

  it "if multiple are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), 
        Place.new( name: "Heinäpaali", id: 2 ),
        Place.new( name: "Pärekatto", id: 3 )
      ]
    )
    allow(WeatherApi).to receive(:get_weather_in).with("kumpula").and_return(
      JSON.parse(weather_hash.to_json, object_class: OpenStruct)
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Heinäpaali"
    expect(page).to have_content "Pärekatto"
    expect(page).to have_content "Current weather in Kumpula"
    expect(page).to have_content "Temperature: 21.9 celsius"
    expect(page).to have_content "Wind: 3.7 m/s, Direction: SouthEast"
  end
end

def weather_hash
  weather_hash = {
    "city" => {
      "name"=>"Kumpula"},
    "temperature" => {
      "value" => "21.9",
      "unit" => "celsius"},
    "wind" => {
      "speed" => {
        "value" => "3.7",
        "unit" => "m/s"},
      "direction" => {
        "name" => "SouthEast"}
    },
    "weather" => { "icon" => "1" }
  }
end
