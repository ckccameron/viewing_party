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

  it "returns up to 40 result for search" do
    VCR.use_cassette("happy_search_results") do
      movies = @service.search("happy")

      expect(movies.count).to eq(40)
      expect(movies.first).to have_key(:title)
      expect(movies.first[:title]).to be_a(String)
      expect(movies.first[:title]).to include("Happy")
      expect(movies.first[:title].length).to be > 0
      expect(movies.first).to have_key(:vote_average)
      expect(movies.first[:vote_average]).to be_a(Integer)
      expect(movies.first[:vote_average]).to be_between(0, 10).inclusive
    end
  end

  it "return movie details" do
    VCR.use_cassette("fight_club_details_results") do
      movie_id = 550
      movie = @service.details(movie_id)

      expect(movie).to have_key(:runtime)
      expect(movie[:runtime]).to be_a(Integer)
      expect(movie[:runtime]).to eq(139)
      expect(movie[:runtime]).to be > 0

      expect(movie).to have_key(:overview)
      expect(movie[:overview]).to be_a(String)
      expect(movie[:overview].length).to be > 0

      expect(movie).to have_key(:genres)
      expect(movie[:genres]).to be_a(Array)
      expect(movie[:genres].first).to be_a(Hash)
      expect(movie[:genres].first).to have_key(:name)
      expect(movie[:genres].first[:name]).to be_a(String)
      expect(movie[:genres].first[:name].length).to be > 0
    end
  end

  it "returns cast members" do
    VCR.use_cassette("fight_club_cast_results") do
      movie_id = 550
      movie = @service.cast(movie_id)

      expect(movie).to have_key(:cast)
      expect(movie[:cast]).to be_a(Array)
      expect(movie[:cast].size).to be > 0
      expect(movie[:cast].first).to be_a(Hash)
      expect(movie[:cast].first).to have_key(:name)
      expect(movie[:cast].first[:name]).to be_a(String)
      expect(movie[:cast].first[:name].length).to be > 0
      expect(movie[:cast].first).to have_key(:character)
      expect(movie[:cast].first[:character]).to be_a(String)
      expect(movie[:cast].first[:character].length).to be > 0
    end
  end

  it "returns reviews" do
    VCR.use_cassette("fight_club_review_results") do

      movie_id = 550
      movie = @service.reviews(movie_id)

      expect(movie).to be_a(Array)
      expect(movie.first).to be_a(Hash)
      expect(movie.first).to have_key(:author)
      expect(movie.first[:author]).to be_a(String)
      expect(movie.first[:author].length).to be > 0
      expect(movie.first).to have_key(:content)
      expect(movie.first[:content]).to be_a(String)
      expect(movie.first[:content].length).to be > 0
    end
  end

  it "returns movie poster images" do
    VCR.use_cassette('fight_club_images_results', allow_playback_repeats: true) do
      movie_id = 550
      movie_posters = @service.posters(movie_id)
      expect(movie_posters).to be_a(Hash)
      expect(movie_posters[:posters]).to be_an(Array)
      expect(movie_posters[:posters].first).to be_a(Hash)
      expect(movie_posters[:posters].first).to have_key(:file_path)
      expect(movie_posters[:posters].first[:file_path]).to be_a(String)
    end
  end

  it "returns movie videos" do
    VCR.use_cassette('fight_club_video_results', allow_playback_repeats: true) do
      movie_id = 550
      movie_videos = @service.videos(movie_id)
      expect(movie_videos).to be_a(Hash)
      expect(movie_videos[:results]).to be_an(Array)
      expect(movie_videos[:results].first).to be_a(Hash)
      expect(movie_videos[:results].first).to have_key(:key)
      expect(movie_videos[:results].first[:key]).to be_a(String)
    end
  end
end
