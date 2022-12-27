require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when visiting ratings page" do
    it "tables for top breweries, beers and styles are shown" do
      visit ratings_path

      expect(page).to have_content "Best breweries"
      expect(page).to have_content "Best beers"
      expect(page).to have_content "Best styles"
    end

    it "given amount of ratings are shown" do
      create_beers_with_many_ratings({ user: user }, 18, 46, 3, 29, 37, 12)

      visit ratings_path

      expect(page).to have_content "Pekka 6 ratings"
      expect(page).to have_content "anonymous 46"
      expect(page).to have_content "anonymous 37"
      expect(page).to have_content "anonymous 12"
    end
  end
end
