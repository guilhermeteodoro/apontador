require 'ffaker'
# This will guess the User class
FactoryGirl.define do
  factory :person, class: Person do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    cpf         { rand(11) }
    address     { Faker::Address.street_name }
    city        { Faker::Address.city }
    phone       { Faker::PhoneNumber.short_phone_number }
    admin       { false }
  end
end
