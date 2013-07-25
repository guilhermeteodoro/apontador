# encoding: utf-8
require 'ffaker'
require "digest/sha1"

FactoryGirl.define do
  factory :employee, class: Person do
    first_name          { Faker::Name.first_name }
    last_name           { Faker::Name.last_name }
    email               { Faker::Internet.email }
    password            { Faker::Name.first_name }
    institution         { nil }
    cpf                 { 11234567891 }
    address             { "#{rand(99999)} #{Faker::Address.street_name}" }
    city                { Faker::Address.city }
    phone               { Faker::PhoneNumber.short_phone_number }
    latitude            { rand(-179.999999..180) }
    longitude           { rand(-84.999999..85) }
    admin               { false }
  end

  factory :manager, class: Person do
    first_name          { Faker::Name.first_name }
    last_name           { Faker::Name.last_name }
    email               { Faker::Internet.email }
    password            { Faker::Name.first_name }
    institution         { Faker::Name.last_name }
    cpf                 { 11234567891 }
    address             { "#{rand(99999)} #{Faker::Address.street_name}" }
    city                { Faker::Address.city }
    phone               { Faker::PhoneNumber.short_phone_number }
    latitude            { rand(-179.999999..180) }
    longitude           { rand(-84.999999..85) }
    admin               { true }
  end
end
