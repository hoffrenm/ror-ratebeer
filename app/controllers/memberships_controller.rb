class MembershipsController < ApplicationController
  def index
    @beer_clubs = BeerClub.all
  end

  def new
    @membership = Membership.new
    @beer_clubs = available_clubs
  end

  def create
    membership = Membership.new(membership_params)
    membership.user = current_user

    if membership.save
      redirect_to beer_club_path(membership.beer_club_id), notice: "Welcome to the club #{current_user.username}"
    else
      @beer_clubs = BeerClub.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    club_membership = current_user.memberships.where(beer_club_id: params[:id]).first
    club_membership.delete

    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "Membership in #{club_membership.beer_club.name} ended." }
      format.json { head :no_content }
    end
  end

  def available_clubs
    joined = Membership.where(user_id: current_user.id).pluck(:beer_club_id)
    BeerClub.where.not(id: joined)
  end

  private

  def membership_params
    params.require(:membership).permit(:beer_club_id)
  end
end
