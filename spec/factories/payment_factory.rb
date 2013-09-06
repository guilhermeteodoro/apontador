# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :payment, class: Payment do
    token       { nil }
    concluded   { [true, false].sample }
    user_id     { rand 1..10 }
  end

end
