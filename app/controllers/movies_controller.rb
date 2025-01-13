require "http"

class MoviesController < ApplicationController

  allow_unauthenticated_access only: %i[index show]

  def index
    movies_data = TmdbService.popular_movies["results"]
    @movies = movies_data.map do |movie_data|
      MoviePresenter.new(
        movie_data,
        backdrop_url: TmdbService.backdrop_url(movie_data["backdrop_path"]),
        poster_url: TmdbService.poster_url(movie_data["poster_path"])
      )
    end
  end

  def show
    id = params[:id].to_s.split("-").first
    movie_data = TmdbService.movie_details(id)
    redirect_to movies_path, alert: "Movie not found" if movie_data.blank? || movie_data.empty?

    @movie = MoviePresenter.new(
      movie_data,
      backdrop_url: TmdbService.backdrop_url(movie_data["backdrop_path"]),
      poster_url: TmdbService.poster_url(movie_data["poster_path"]),
      credits: TmdbService.movie_credits(id)
    )
  end

end
