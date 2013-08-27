# encoding: utf-8
require 'ffaker'
require "digest/sha1"

FactoryGirl.define do

  factory :user, class: User do

    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    username        { Faker::Name.first_name.downcase }
    hour_value      { rand(1.0..200.0) }
    email           { Faker::Internet.email }
    plain_password  { Faker::Name.first_name }
    street          { Faker::Address.street_name }
    city            { Faker::Address.city }
    number          { rand(99999) }
    latitude        { rand(-179.999999..180) }
    longitude       { rand(-84.999999..85) }
    company_id      { rand(1..10) }
    manager         { false }

  end
end
