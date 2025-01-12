class RegistrationsController < ApplicationController

  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> {
  redirect_to new_session_url, alert: "Try again later." }

  def new
    @user = User.new
  end

  # https://guides.rubyonrails.org/getting_started.html#creating-products
  def create
    @user = User.new(user_params)

    if @user.save
      # Create a session for the user
      start_new_session_for @user

      # Profile will be created by the after_create callback in the User model

      # Redirect to the profile page
      # TODO: Display a success message on profile page
      redirect_to profile_path(user_id: @user.id), notice: "Account created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :username, :email_address, :password ])
  end

end
