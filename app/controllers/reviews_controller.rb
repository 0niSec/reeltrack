class ReviewsController < ApplicationController

  def create
    @movie = Movie.find_by!(tmdb_id: params[:movie_id])

    # Create or update watched movie entry
    @watched_movie = WatchedMovie.find_or_create_by(
      user: Current.user,
      movie: @movie
    )
    @watched_movie.update(
      rating: params[:rating],
      watched_on: params[:watched_on]
    )

    # Create review if content provided
    if params[:content].present?
      @review = MovieReview.new(
        movie: @movie,
        user: Current.user,
        watched_movie: @watched_movie,
        content: params[:content]
      )
      @review.save
    end

    render turbo_stream: turbo_stream.replace(
      "movie_reviews",
      partial: "shared/reviews",
      locals: { movie: @movie }
    )
  end

  private

  def review_params
    params.permit(:content, :rating, :watched_on)
  end

end
