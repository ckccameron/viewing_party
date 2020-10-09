class MovieService
  def top_rated
    movies = []
    page = 0
    while movies.size < 40
      page +=1
      params = { page: page }
      movies << to_json("movie/top_rated", params)[:results]
      movies.flatten!
      break if movies == [nil]
    end
    movies
  end

  def to_json(url, params)
    response = conn.get(url) do |req|
      req.params = params
      req.params['api_key'] = ENV['TMDB_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'https://api.themoviedb.org/3/')
  end
end
