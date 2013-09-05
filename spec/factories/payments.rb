# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    toke 1
    date "2013-09-05 17:49:02"
    concluded false
  end
end
