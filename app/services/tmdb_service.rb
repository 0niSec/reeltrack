require "http"

class TmdbService

  BASE_URL = "https://api.themoviedb.org/3"
  IMAGE_BASE_URL = "https://image.tmdb.org/t/p"

  class << self

    def find_movie(tmdb_id)
      get("/movie/#{tmdb_id}")
    end

    def search_movies(query)
      return [] if query.blank?

      response = get("/search/movie", query: query)
      response["results"] || []
    end

    def movie_credits(id)
      get("/movie/#{id}/credits")
    end

    def popular_movies
      get("/movie/popular")
    end

    def movie_details(id)
      get("/movie/#{id}")
    end

    def movie_credits(id)
      get("/movie/#{id}/credits")
    end

    def backdrop_url(path, size: "w1280")
      return nil if path.blank?
      "#{IMAGE_BASE_URL}/#{size}#{path}"
    end

    def poster_url(path, size: "w500")
      return nil if path.blank?
      "#{IMAGE_BASE_URL}/w500#{path}"
    end

    private

    def get(path, params = {})
      response = HTTP
        .auth("Bearer #{ENV['TMDB_ACCESS_TOKEN']}")
        .accept("application/json")
        .get(
          "#{BASE_URL}#{path}",
          params: params.merge(language: "en-US")
        )

      if response.status.success?
        response.parse
      else
        Rails.logger.error "TMDB API Error: #{response.status} - #{response.body}"
        {}
      end
    rescue HTTP::Error => e
      Rails.logger.error "HTTP Request Error: #{e.message}"
      {}
    end

  end

end
