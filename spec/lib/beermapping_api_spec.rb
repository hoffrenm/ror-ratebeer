require 'rails_helper'

describe "BeermappingApi" do
  it "When HTTP GET returns no entries, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
    <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*ihmemaa/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("ihmemaa")

    expect(places.size).to eq(0)
  end

  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18856</id><name>Panimoravintola Koulu</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18856</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18856&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18856&amp;d=1&amp;type=norm</blogmap><street>Eerikinkatu 18</street><city>Turku</city><state></state><zip>20100</zip><country>Finland</country><phone>(02) 274 5757</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*turku/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("turku")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("Panimoravintola Koulu")
    expect(place.street).to eq("Eerikinkatu 18")
  end

  it "When HTTP GET returns multiple entries, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18098</id><name>Panimoravintola Beer Hunter's</name><status>Beer Bar</status><reviewlink>https://beermapping.com/location/18098</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18098&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18098&amp;d=1&amp;type=norm</blogmap><street>Antinkatu 11</street><city>Pori</city><state></state><zip>28100</zip><country>Finland</country><phone>+358 2 6415599</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>18149</id><name>Ravintola Kirjakauppa</name><status>Beer Bar</status><reviewlink>https://beermapping.com/location/18149</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18149&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18149&amp;d=1&amp;type=norm</blogmap><street>Antinkatu 10</street><city>Pori</city><state></state><zip>29100</zip><country>Finland</country><phone>045 358 77 93</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>18854</id><name>Panimoravintola Beer Hunter's</name><status>Brewery</status><reviewlink>https://beermapping.com/location/18854</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18854&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18854&amp;d=1&amp;type=norm</blogmap><street>Antinkatu 11</street><city>Pori</city><state></state><zip>28100</zip><country>Finland</country><phone>+358 2 641 55 99</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>18862</id><name>Ruosniemen Panimo</name><status>Brewery</status><reviewlink>https://beermapping.com/location/18862</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18862&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18862&amp;d=1&amp;type=norm</blogmap><street>Eetunkuja 6</street><city>Pori</city><state></state><zip>28220</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location><location><id>18907</id><name>Radius Brewing Company</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18907</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18907&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18907&amp;d=1&amp;type=norm</blogmap><street>610 Merchant Street</street><city>Emporia</city><state>KS</state><zip>66801</zip><country>United States</country><phone>(620) 208-4677</phone><overall>81.66665</overall><imagecount>0</imagecount></location><location><id>21539</id><name>Beer Hunters</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/21539</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21539&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21539&amp;d=1&amp;type=norm</blogmap><street>Antinkatu 11</street><city>Pori</city><state>Etela-Suomen Laani</state><zip>28100</zip><country>Finland</country><phone>+358 2 641 55 99</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21544</id><name>Rocking Bear Brewers</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21544</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21544&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21544&amp;d=1&amp;type=norm</blogmap><street>Kuriirintie 12 B</street><city>Pori</city><state>Lansi-Suomen Laani</state><zip>28430</zip><country>Finland</country><phone>+358442369692</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*pori/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("pori")

    expect(places.size).to eq(7)
    place1 = places.first
    place2 = places.last
    expect(place1.name).to eq("Panimoravintola Beer Hunter's")
    expect(place1.street).to eq("Antinkatu 11")
    expect(place1.city).to eq("Pori")
    expect(place2.name).to eq("Rocking Bear Brewers")
    expect(place2.street).to eq("Kuriirintie 12 B")
  end

end