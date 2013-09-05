FactoryGirl.define do
  factory :checking do
    checked_in_at   { Time.now }
    checked_out_at  { Time.now + rand(1..6).hours + rand(1..59).minutes }
    approved        { [true, false].sample }
    paid            { [true, false].sample }
    hour_value      { rand(10.0..70.0) }
    user_id         { rand(0..1) }
  end

  factory :predefined_checking, class: Checking do
    checked_in_at   "2013-09-04 12:00:00"
    checked_out_at  "2013-09-04 14:41:10"
    approved        { [true, false].sample }
    paid            { [true, false].sample }
    hour_value      { rand(10.0..70.0) }
    user_id         { rand(0..1) }
  end
end
