FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true, special_characters: true) }
    created_at { Time.now }
    updated_at { Time.now}
  end
end
