class MoviePresenter

  attr_reader :backdrop_url, :poster_url, :credits

  def initialize(movie_data, backdrop_url: nil, poster_url: nil, credits: {})
    @movie = movie_data
    @backdrop_url = backdrop_url
    @poster_url = poster_url
    @credits = credits
  end

  # Convenience methods for commonly used data
  def title
    @movie["title"]
  end

  def overview
    @movie["overview"]
  end

  def release_date
    Date.parse(@movie["release_date"]) if @movie["release_date"].present?
  end

  def runtime
    "#{@movie['runtime']} min" if @movie["runtime"].present?
  end

  def rating
    @movie["vote_average"]&.round(1)
  end

  # Add these methods for ratings
  def average_rating
    @movie["vote_average"]&.round(1)
  end

  def ratings_count
    @movie["vote_count"]
  end

  def likes_count
    # TMDB doesn't have likes, so we could use popularity or vote_count
    @movie["popularity"]&.round(0) || 0
  end

  def tagline
    @movie["tagline"]
  end

  def genres
    @movie["genres"]&.map { |g| g["name"] } || []
  end

  # Cast methods
  def cast
    @credits.dig("cast")&.map { |member| CastMember.new(member) } || []
  end

  def crew
    @credits.dig("crew")&.map { |member| CrewMember.new(member) } || []
  end

  # Fallback to raw data if method not defined
  def method_missing(method_name, *args, &block)
    @movie[method_name.to_s] || super
  end

  # It's good practice to also define respond_to_missing?
  def respond_to_missing?(method_name, include_private = false)
    @movie.key?(method_name.to_s) || super
  end

  def slug
    "#{@movie['id']}-#{title.parameterize}"
  end

  def to_param
    slug
  end

  private

  class CastMember

    attr_reader :name, :character

    def initialize(data)
      @name = data["name"]
      @character = data["character"]
      @profile_path = data["profile_path"]
    end

    def profile_image_url
      if @profile_path.present?
        TmdbService.poster_url(@profile_path)
      else
        # You can use your own default avatar image path here
        "https://ui-avatars.com/api/?name=#{URI.encode_www_form_component(name)}&background=334155&color=fff"
      end
    end

  end

  class CrewMember

    attr_reader :name, :job, :department

    def initialize(data)
      @name = data["name"]
      @job = data["job"]
      @department = data["department"]
      @profile_path = data["profile_path"]
    end

    def profile_image_url
      if @profile_path.present?
        TmdbService.poster_url(@profile_path)
      else
        # You can use your own default avatar image path here
        "https://ui-avatars.com/api/?name=#{URI.encode_www_form_component(name)}&background=334155&color=fff"
      end
    end

  end

end
