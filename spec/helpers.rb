module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_beer_with_rating(object, score)
    beer = FactoryBot.create(:beer)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
  end
  
  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
      create_beer_with_rating(object, score)
    end
  end

  def populate_user_with_beers_ratings(object)
    brew1 = FactoryBot.create(:brewery, name: "Koff", year: 1897 )
    brew2 = FactoryBot.create(:brewery, name: "Malmgard", year: 2001 )
    brew3 = FactoryBot.create(:brewery, name: "Weihenstephaner", year: 1040 )

    beer1 = FactoryBot.create(:beer, name: "Iso 3", style: "Lager", brewery: brew1)
    beer2 = FactoryBot.create(:beer, name: "Karhu Laku Porter", style: "Porter", brewery: brew1)
    beer3 = FactoryBot.create(:beer, name: "X Porter", style: "Porter", brewery: brew2)
    beer4 = FactoryBot.create(:beer, name: "Helles", style: "Lager", brewery: brew3)
    beer5 = FactoryBot.create(:beer, name: "Hefeweizen", style: "Weizen", brewery: brew3)

    FactoryBot.create(:rating, beer: beer1, score: 34, user: object[:user] )
    FactoryBot.create(:rating, beer: beer2, score: 2, user: object[:user] )
    FactoryBot.create(:rating, beer: beer3, score: 41, user: object[:user] )
    FactoryBot.create(:rating, beer: beer4, score: 36, user: object[:user] )
    FactoryBot.create(:rating, beer: beer5, score: 9, user: object[:user] )
  end
end