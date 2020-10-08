class SearchResults
  def self.top_rated_movies
    json = service.top_rated
    json.map {|data| movie(data)} unless json.compact.empty?
  end

  private

  def self.service
    MovieService.new
  end

  def self.movie(data)
    Movie.new(data)
  end
end
