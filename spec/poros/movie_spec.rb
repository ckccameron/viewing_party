require 'rails_helper'

describe Movie do
  before :each do
    @movie_data = {
                    id: 1,
                    title: "Batman",
                    vote_average: 8.5,
                    runtime: 100,
                    overview: "Batman rocks",
                    genres: [{
                            "id": 18,
                            "name": "Drama"
                          },
                          {
                            "id": 20,
                            "name": "Action"
                          }],
                    cast: [
                            {
                                "cast_id": 4,
                                "character": "The Narrator",
                                "credit_id": "52fe4250c3a36847f80149f3",
                                "gender": 2,
                                "id": 819,
                                "name": "Edward Norton",
                                "order": 0,
                                "profile_path": "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg"
                            },
                            {
                                "cast_id": 5,
                                "character": "Tyler Durden",
                                "credit_id": "52fe4250c3a36847f80149f7",
                                "gender": 2,
                                "id": 287,
                                "name": "Brad Pitt",
                                "order": 1,
                                "profile_path": "/cckcYc2v0yh1tc9QjRelptcOBko.jpg"
                            }],
                      reviews: [{
                                    "author": "Goddard",
                                    "content": "Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.",
                                    "id": "5b1c13b9c3a36848f2026384",
                                    "url": "https://www.themoviedb.org/review/5b1c13b9c3a36848f2026384"
                                },
                                {
                                    "author": "Brett Pascoe",
                                    "content": "In my top 5 of all time favourite movies. Great story line and a movie you can watch over and over again.",
                                    "id": "5b3e1ba1925141144c007f17",
                                    "url": "https://www.themoviedb.org/review/5b3e1ba1925141144c007f17"
                                }],
                      poster: {
                                :aspect_ratio=>0.6666666666666666,
                                :file_path=>"/jSziioSwPVrOy9Yow3XhWIBDjq1.jpg",
                                :height=>3000,
                                :iso_639_1=>"fr",
                                :vote_average=>5.384,
                                :vote_count=>2,
                                :width=>2000
                              }
                          }


    @movie = Movie.new(@movie_data)
  end

  it "has attributes" do
    expect(@movie).to be_a(Movie)
    expect(@movie.id).to eq(1)
    expect(@movie.title).to eq("Batman")
    expect(@movie.vote_average).to eq(8.5)
    expect(@movie.runtime).to eq(100)
    expect(@movie.overview).to eq("Batman rocks")
    expect(@movie.genres).to eq("Drama, Action")
    expect(@movie.cast).to eq(["Edward Norton as The Narrator", "Brad Pitt as Tyler Durden" ])
    expect(@movie.reviews.all? { |review| review.class == Review }).to be_truthy
    expect(@movie.poster).to eq("https://image.tmdb.org/t/p/w185/jSziioSwPVrOy9Yow3XhWIBDjq1.jpg")
  end

  it "has genre formatting method" do
    genres = @movie_data[:genres]
    result = "Drama, Action"

    expect(@movie.format_genres(genres)).to eq(result)
  end

  it "has a cast formatting method" do
    cast = @movie_data[:cast]

    results = ["Edward Norton as The Narrator", "Brad Pitt as Tyler Durden" ]

    expect(@movie.format_cast(cast)).to eq(results)
  end

  it "has a generate_reviews method" do
    reviews = @movie_data[:reviews]

    expect(@movie.generate_reviews(reviews)).to be_a(Array)
    expect(@movie.generate_reviews(reviews).all? Review).to be_truthy
  end

  it "has a runtime formatting method" do
    expect(@movie.formatted_runtime).to eq('1 hr 40 min')
  end
end
