require 'rails_helper'

describe MovieService do
  before :each do
    @service = MovieService.new
  end

  it "exists" do
    expect(@service).to be_a(MovieService)
  end

  it "returns 40 top rated movies" do
    movies = @service.top_rated

    expect(movies.count).to eq(40)
    expect(movies.first[:title]).to be_a(String)
    expect(movies.first[:vote_average]).to be_a(Float)
  end
end
