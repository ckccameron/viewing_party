class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :overview,
              :genres,
              :cast,
              :reviews
  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @overview = data[:overview]
    @genres = format_genres(data[:genres]) if data[:genres]
    @cast = format_cast(data[:cast]) if data[:cast]
    @reviews = generate_reviews(data[:reviews]) if data[:reviews]
  end

  def format_genres(genres)
    genres.map { |genre| genre[:name] }.join(', ')
  end

  def format_cast(cast)
    cast.map { |actor| "#{actor[:name]} as #{actor[:character]}" }.first(10)
  end

  def generate_reviews(reviews)
    reviews.map { |review_data| Review.new(review_data) }
  end

  def formatted_runtime
    "#{@runtime / 60} hr #{@runtime % 60} min"
  end
end
