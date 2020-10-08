class MovieService
  def top_rated
    movies = []
    i = 0
    while movies.size < 40
      i +=1
      movies << to_json("movie/top_rated?page=#{i}")[:results]
      movies.flatten!
      break if movies == [nil]
    end
    movies
  end

  def to_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'https://api.themoviedb.org/3/') do |req|
      req.params['api_key'] = ENV['TMDB-API-KEY']
    end
  end
end
