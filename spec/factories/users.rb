FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}"}
    sequence(:email) { |n| "user-#{n}@test.com"}
    sequence(:password) { |n| "testPassword#{n}"}
  end
end
