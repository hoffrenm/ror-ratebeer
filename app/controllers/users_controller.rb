class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:destroy, :toggle_activity]

  # GET /users or /users.json
  def index
    @users = User.includes(:beers, :ratings).all
    @current_user = current_user
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def toggle_activity
    user = User.find(params[:id])
    user.update_attribute :active, !user.active

    new_status = user.active? ? "activated" : "closed"
    redirect_to user, notice: "User account is now #{new_status}"
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.active = true

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    return unless current_user == @user

    respond_to do |format|
      if user_params[:username].nil? && @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      if current_user.admin
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      else
        reset_session
        format.html { redirect_to root_path, notice: "We are sorry to see you go" }
      end

      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
