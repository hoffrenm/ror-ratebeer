class MembershipsController < ApplicationController
  def index
    @beer_clubs = BeerClub.all
  end

  def new
    @membership = Membership.new
    @beer_clubs = available_clubs
  end

  def create
    membership = Membership.new params.require(:membership).permit(:beer_club_id)
    membership.user = current_user

    if membership.save
      redirect_to user_path current_user
    else
      @beer_clubs = BeerClub.all
      render :new, status: :unprocessable_entity
    end
  end

  def available_clubs
    joined = Membership.where(user_id: current_user.id).pluck(:beer_club_id)
    BeerClub.where.not(id: joined)
  end
end
