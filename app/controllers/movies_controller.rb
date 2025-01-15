require "http"

class MoviesController < ApplicationController

  allow_unauthenticated_access only: %i[index show]

  def index
    @movies = Movie.order(release_date: :desc)
  end

  def show
    @movie = Movie.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to movies_path, alert: "Movie not found"
  end

end
