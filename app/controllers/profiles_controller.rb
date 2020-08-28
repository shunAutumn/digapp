class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile, only: [:show, :edit, :update]

  def show
  end

  def new 
    return redirect_to edit_profile_path(current_user.profile) if current_user.profile.present?
    @profile = Profile.new
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to root_path, notice: "Profile is made!"
    else
      render :new
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to root_path, notice: "Profile is updated!"
    else
      render :new
    end
  end

  def destroy
  end

  private

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(
      :name, :image
    )
  end
end
