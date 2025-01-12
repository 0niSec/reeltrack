class TmdbService

  BASE_URL = "https://api.themoviedb.org/3"
  API_KEY = ENV["TMDB_API_KEY"]

  class << self

    def popular_movies
      get("/movie/popular")
    end

    def movie_details(id)
      get("/movie/#{id}")
    end

    private

    def get_request(path, params = {})
      url = URI("#{BASE_URL}#{path}")
      url.query = URI.encode_www_form(params.merge(api_key: API_KEY))

      response = Net::HTTP.get(url)
      JSON.parse(response)
    end

  end

end
