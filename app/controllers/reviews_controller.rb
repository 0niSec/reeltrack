class ReviewsController < ApplicationController

  before_action :require_authentication

  def create
    @movie = Movie.find_by!(tmdb_id: params[:movie_id])
    @watched_movie = Current.user.watched_movies.find_or_create_by(movie: @movie)

    @watched_movie.update(watched_movie_params)

    @review = MovieReview.new(
      movie: @movie,
      user: Current.user,
      watched_movie: @watched_movie,
      content: params[:content]
    )

    if @review.save
      redirect_to @movie, notice: "Review posted successfully"
    else
      redirect_to @movie, alert: "Error posting review: #{@review.errors.full_messages.join(', ')}"
    end
  end

  private

  def watched_movie_params
    params.permit(:rating, :liked, :watched_date)
  end

end
