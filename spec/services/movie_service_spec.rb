require 'rails_helper'

describe MovieService do
  before :each do
    @service = MovieService.new
  end

  it "exists" do
    expect(@service).to be_a(MovieService)
  end

  it "returns 40 top rated movies" do
    VCR.use_cassette("top_40_rated_movies") do
      movies = @service.top_rated

      expect(movies.count).to eq(40)
      expect(movies.first).to have_key(:title)
      expect(movies.first[:title]).to be_a(String)
      expect(movies.first[:title].length).to be > 0
      expect(movies.first).to have_key(:vote_average)
      expect(movies.first[:vote_average]).to be_a(Float)
      expect(movies.first[:vote_average]).to be_between(0, 10).inclusive
    end
  end
end
