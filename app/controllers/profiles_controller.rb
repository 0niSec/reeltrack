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

    # 1/12/2025 - Avatar upload works and preview works while editing profile
    # But it won't seem to handle images that are too large or the incorrect size

    # Handle avatar first if present
    if params.dig(:profile, :user_attributes, :avatar).present?
      @user.avatar.attach(params[:profile][:user_attributes][:avatar])
      unless @user.save
        flash.now[:alert] = @user.errors.full_messages.join(", ")
        render :edit, status: :unprocessable_entity
        return
      end
    end

    # Then handle profile updates
    if @profile.update(profile_params)
      redirect_to profile_path(user_id: @user.id), notice: "Profile updated successfully!"
    else
      flash.now[:alert] = @profile.errors.full_messages.join(", ")
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
    params.require(:profile).permit(
      :bio,
      :favorite_movies,
      :favorite_shows,
      user_attributes: [ :id, :avatar ]
    )
  end

end
