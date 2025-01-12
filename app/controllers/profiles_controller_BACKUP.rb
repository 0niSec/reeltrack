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
    @user = @profile.user

    if @profile.update(profile_params)
      # Handle avatar upload separately
      if params.dig(:profile, :user_attributes, :avatar).present?
        @user.avatar.attach(params[:profile][:user_attributes][:avatar])
      end

      redirect_to profile_path(user_id: @user.id), notice: "Profile updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def set_profile
    # Set the profile and user
    # Use @ here to make it available in the view
    @profile = Profile.find_by(user_id: params[:user_id])
    @user = @profile.user
  end

  # Helper method because we only need the return
  private

  def profile_params
    # Remove user_attributes from profile_params since we're handling it separately
    params.expect(profile: [ :bio, :favorite_movies, :favorite_shows ])
  end

  def user_params
    params.require(:profile).require(:user).expect(user: [ :avatar ])
  end

end
