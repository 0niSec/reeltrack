class TmdbController < ApplicationController

  def show
    tmdb_id = params[:id]
    @movie = Movie.find_by(tmdb_id: tmdb_id)

    if @movie
      redirect_to movie_path(@movie)
      return
    end

    movie_data = TmdbService.movie_details(tmdb_id)
    credits_data = TmdbService.movie_credits(tmdb_id)

    if movie_data.present? && !movie_data.empty?
      Rails.logger.info "Importing movie: #{movie_data["title"]}"
      Rails.logger.info "Movie data: #{movie_data.inspect}"

      ActiveRecord::Base.transaction do
        @movie = Movie.create!(
          tmdb_id: movie_data["id"].to_s,
          title: movie_data["title"],
          overview: movie_data["overview"],
          tagline: movie_data["tagline"],
          release_date: Date.parse(movie_data["release_date"]),
          runtime: movie_data["runtime"],
          poster_url: TmdbService.poster_url(movie_data["poster_path"]),
          backdrop_url: TmdbService.backdrop_url(movie_data["backdrop_path"]),
          tmdb_rating: movie_data["vote_average"],
          tmdb_votes_count: movie_data["vote_count"]
        )

        # Genres
        movie_data["genres"]&.each do |genre|
          genre = Genre.find_or_create_by(
            tmdb_id: genre["id"].to_s,
            name: genre["name"]
          )
          @movie.genres << genre
        end

        credits_data["cast"]&.first(10)&.each do |cast_member|
          person = Person.find_or_create_by(tmdb_id: cast_member["id"].to_s) do |p|
            p.name = cast_member["name"]
            p.profile_url = TmdbService.poster_url(cast_member["profile_path"])
          end

          MovieCastMember.create!(
            movie: @movie,
            person: person,
            character_name: cast_member["character"],
            order: cast_member["order"] + 1
          )
        end

        credits_data["crew"]&.each do |crew_member|
          person = Person.find_or_create_by(tmdb_id: crew_member["id"].to_s) do |p|
            p.name = crew_member["name"]
            p.profile_url = TmdbService.poster_url(crew_member["profile_path"])
          end

          MovieCrewMember.create!(
            movie: @movie,
            person: person,
            job: crew_member["job"],
            department: crew_member["department"]
          )
        end
      end

      redirect_to movie_path(@movie)
    else
      redirect_to search_path, alert: "Movie not found"
    end
  rescue => e
    Rails.logger.error "Failed to import movie: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    redirect_to search_path, alert: "Failed to import movie"
  end

end
