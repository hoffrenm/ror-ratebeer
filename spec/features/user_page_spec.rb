require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "can see user's given ratings on user page" do
    user1 = FactoryBot.create(:user, username: "Aku")
    user2 = FactoryBot.create(:user, username: "Iines")

    create_beers_with_many_ratings({ user: user1 }, 12, 30, 42)
    create_beer_with_rating({ user: user2 }, 15)

    visit user_path(user1)

    expect(page).to have_content "#{user1.username} has made 3 ratings"
    expect(page).to have_content "anonymous 12"
    expect(page).to have_content "anonymous 42"
    expect(page).not_to have_content "anonymous 15"
  end

  it "can delete a given rating on user page" do
    user = FactoryBot.create(:user, username: "Aku")
    sign_in(username: "Aku", password: "Foobar1")

    create_beers_with_many_ratings({ user: user }, 12, 30, 42)

    visit user_path(user)


    page.within("#ratings") do
      click_link("delete", href: "/ratings/2")
    end

    page.save_and_open_page

    
    expect(page).to have_content "#{user.username} has made 2 ratings"
    expect(Rating.count).to eq(2)
  end

  it "can see user's favorite style of beer on user page" do
    user = FactoryBot.create(:user, username: "Aku")
    populate_user_with_beers_ratings({ user: user })

    visit user_path(user)

    expect(page).to have_content "Favorite style of beer: Lager"
  end

  it "can see user's favorite brewery on user page" do
    user = FactoryBot.create(:user, username: "Aku")
    populate_user_with_beers_ratings({ user: user })

    visit user_path(user)

    expect(page).to have_content "Favorite brewery: Malmgard"
  end
end
