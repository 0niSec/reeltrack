class SearchController < ApplicationController

  def index
    @query = params[:q]
    @movies = if @query.present?
      Movie.search(@query)
    else
      Movie.none
    end

    if @query.present? && @movies.empty?
      @tmdb_results = TmdbService.search_movies(@query)
    end
  end

end
