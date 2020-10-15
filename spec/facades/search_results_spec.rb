require 'rails_helper'

describe SearchResults do
  it "returns top rated movies" do
    VCR.use_cassette('top_40_rated_movies', allow_playback_repeats: true) do
      movies = SearchResults.top_rated_movies

      expect(movies).to be_an(Array)
      expect(movies.first).to be_a(Movie)
      expect(movies.first.title).to be_a(String)
      expect(movies.first.vote_average).to be_an(Float)
    end
  end

  it "returns results for a movie search by a user" do
    VCR.use_cassette('happy_search_results', allow_playback_repeats: true) do
      movies = SearchResults.movie_search("happy")

      expect(movies).to be_an(Array)
      expect(movies.first).to be_a(Movie)
      expect(movies.first.title).to be_a(String)
      expect(movies.first.vote_average).to be_an(Integer)
    end
  end

  it "returns movie details such as title, vote average, runtime, overview and genres as well as cast and reviews" do
    VCR.use_cassette('fight_club_details_results', allow_playback_repeats: true) do
      VCR.use_cassette('fight_club_cast_results', allow_playback_repeats: true) do
        VCR.use_cassette('fight_club_review_results', allow_playback_repeats: true) do
          fight_club_id = 550
          movie = SearchResults.movie_details(fight_club_id)

          expect(movie).to be_a(Movie)
          expect(movie.cast).to be_an(Array)
          expect(movie.reviews).to be_an(Array)
          expect(movie.cast).to_not eq(nil)
          expect(movie.genres).to_not eq(nil)
          expect(movie.id).to_not eq(nil)
          expect(movie.overview).to_not eq(nil)
          expect(movie.reviews).to_not eq(nil)
          expect(movie.runtime).to_not eq(nil)
          expect(movie.title).to_not eq(nil)
          expect(movie.vote_average).to_not eq(nil)
        end
      end
    end
  end

  it "returns movie details without including data for cast and reviews" do
    VCR.use_cassette('fight_club_details_results', allow_playback_repeats: true) do
      fight_club_id = 550
      movie = SearchResults.party_details(fight_club_id)

      expect(movie).to be_a(Movie)
      expect(movie.id).to_not eq(nil)
      expect(movie.title).to_not eq(nil)
      expect(movie.vote_average).to_not eq(nil)
    end
  end

  it "returns movie poster" do
    VCR.use_cassette('fight_club_details_results', allow_playback_repeats: true) do
      VCR.use_cassette('fight_club_images_results', allow_playback_repeats: true) do
        fight_club_id = 550
        movie = SearchResults.movie_details(fight_club_id)

        expect(movie).to be_a(Movie)
        expect(movie.poster).to be_a(String)
        expect(movie.poster).to_not eq(nil)
      end
    end
  end

  it "returns movie video key" do
    VCR.use_cassette('fight_club_details_results', allow_playback_repeats: true) do
      VCR.use_cassette('fight_club_videos_results', allow_playback_repeats: true) do
        fight_club_id = 550
        movie = SearchResults.movie_details(fight_club_id)

        expect(movie).to be_a(Movie)
        expect(movie.video).to be_a(String)
        expect(movie.video).to_not eq(nil)
      end
    end
  end
end
