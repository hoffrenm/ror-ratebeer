require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Testwery" }
  let!(:user) { FactoryBot.create :user }

  it "can be created with valid fields" do
    sign_in(username: "Pekka", password: "Foobar1")

    visit new_beer_path
    fill_in("beer[name]", with: "Mahtava olut")

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end
  
  it "shows error if name is missing" do
    sign_in(username: "Pekka", password: "Foobar1")

    visit new_beer_path
    click_button "Create Beer"

    expect(Beer.count).to eq(0)
    expect(page).to have_content "1 error"
    expect(page).to have_content "Name can't be blank"
  end
end