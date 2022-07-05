# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { 'Smith' }
    dob { Time.zone.now }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
