require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::TvShows::RickAndMorty.character }
    email { Faker::Internet.free_email(name: name)}
    password { "password123" }
  end
end
