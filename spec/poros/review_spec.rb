require 'rails_helper'

describe Review do
  it "has attributes" do
    review_data = {
                  "author": "Goddard",
                  "content": "Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.",
                  "id": "5b1c13b9c3a36848f2026384",
                  "url": "https://www.themoviedb.org/review/5b1c13b9c3a36848f2026384"
              }
    review = Review.new(review_data)

    expect(review).to be_a(Review)
    expect(review.author).to eq("Goddard")
    expect(review.content).to eq("Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.")
  end
end
