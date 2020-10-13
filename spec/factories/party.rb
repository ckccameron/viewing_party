require 'faker'

FactoryBot.define do
  factory :party do
    movie_title { Faker::Movie.title }
    movie_id { Faker::Number.number(digits: 2) }
    duration { 150 }
    datetime { Faker::Time.between(from: DateTime.now, to: DateTime.tomorrow)}
  end
end
