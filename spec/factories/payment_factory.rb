# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :payment, class: Payment do
    concluded   { [true, false].sample }
    user_id     { rand 1..10 }
  end

end
