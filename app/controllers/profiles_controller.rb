class ProfilesController < ApplicationController

  allow_unauthenticated_access only: %i[ show ]

  before_action :resume_session, only: %i[ show ]
  before_action :require_authentication, only: %i[ edit update ]
  before_action :set_profile, only: %i[ show edit update ]

  def show
    @profile = Profile.find_by(user_id: params[:user_id])
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(user_id: @profile.user_id), notice: "Profile updated successfully!"
    else
      flash.now[:alert] = @profile.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find_by(user_id: params[:user_id])

    if @profile.nil?
      redirect_to root_path, alert: "Profile not found"
    end

    @user = @profile.user
  end

  def profile_params
    params.expect(profile: [ :bio, :favorite_movies, :favorite_shows, :avatar ])
  end

end
