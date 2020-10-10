require 'rails_helper'

describe Movie do
  before :each do
    @movie_data = {
                    id: 1,
                    title: "Batman",
                    vote_average: 8.5
                  }

    @movie = Movie.new(@movie_data)
  end
  
  it "has attributes" do
    expect(@movie).to be_a(Movie)
    expect(@movie.id).to eq(1)
    expect(@movie.title).to eq("Batman")
    expect(@movie.vote_average).to eq(8.5)
  end
end
