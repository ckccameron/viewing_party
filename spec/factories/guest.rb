require 'faker'

FactoryBot.define do
  factory :guest do
    party_id {}
    user_id {}
    is_host {}
  end
end
