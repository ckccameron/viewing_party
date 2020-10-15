class SearchResults
  def self.top_rated_movies
    json = service.top_rated
    json.map { |data| movie(data) } unless json.compact.empty?
  end

  def self.movie_search(query)
    json = service.search(query)
    json.map { |data| movie(data) } unless json.compact.empty?
  end

  def self.movie_details(id)
    data = service.details(id)
    data[:cast] = service.cast(id)[:cast]
    data[:reviews] = service.reviews(id)
    data[:poster] = service.posters(id)[:posters].first
    data[:video] = get_youtube_video(id)

    movie(data)
  end

  def self.party_details(id)
    data = service.details(id)

    movie(data)
  end

  def self.get_youtube_video(id)
    video = service.videos(id)[:results].find do |video_data|
      video_data[:site] == "YouTube"
    end
    video[:key] if video
  end

  def self.service
    MovieService.new
  end

  def self.movie(data)
    Movie.new(data)
  end
end
