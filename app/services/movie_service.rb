class MovieService
  def top_rated
    aggregator('movie/top_rated')
  end

  def search(query)
    params = { query: query }
    aggregator('search/movie', params)
  end

  def details(movie_id)
    to_json("movie/#{movie_id}")
  end

  def cast(movie_id)
    to_json("movie/#{movie_id}/credits")
  end

  def reviews(movie_id)
    aggregator("movie/#{movie_id}/reviews")
  end

  def posters(movie_id)
    to_json("movie/#{movie_id}/images")
  end

  def videos(movie_id)
    to_json("movie/#{movie_id}/videos")
  end

  def aggregator(url, params = {})
    movies = []
    page = 0
    while movies.size < 40
      page += 1
      params[:page] = page
      page_content = to_json(url, params)[:results]
      (movies << page_content).flatten!
      break if movies.include?(nil) || page_content.size < 20
    end
    movies
  end

  def to_json(url, params = {})
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
