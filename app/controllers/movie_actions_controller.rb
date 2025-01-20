class MovieActionsController < ApplicationController

  before_action :set_movie
  before_action :require_authentication

  def watch
    puts "Params received: #{params.inspect}"  # Debug params
    @watched_movie = Current.user.watched_movies.find_or_initialize_by(movie: @movie)
    @watched_movie.assign_attributes(watched_movie_params)
    puts "WatchedMovie: #{@watched_movie.inspect}"  # Debug object

    if @watched_movie.save
      head :ok
    else
      render json: { errors: @watched_movie.errors }, status: :unprocessable_entity
    end
  end

  def like
    @liked_movie = Current.user.liked_movies.build(liked_movie_params)
    @liked_movie.movie = @movie

    if @liked_movie.save
      redirect_to @movie, notice: "Liked #{@liked_movie.liked}"
    else
      redirect_to @movie, alert: "Failed to save liked movie"
    end
  end

end

private

def set_movie
  @movie = Movie.find_by(tmdb_id: params[:id])
end

def watched_movie_params
  params.permit(:watched_date, :rating, :liked)
end

def liked_movie_params
  params.expect(liked_movie: [ :liked ])
end
