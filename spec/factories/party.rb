require 'faker'

FactoryBot.define do
  factory :party do
    movie_title { Faker::Movie.title }
    duration { 150 }
    date { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    start_time { "11:09 AM" }
    guests { [] }
  end
end
