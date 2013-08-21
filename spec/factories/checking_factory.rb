FactoryGirl.define do

  factory :checking, class: Checking do

    checked_in_at   { Time.now }
    checked_out_at  { Time.now + rand(1..4).hours }
    hour_value      { rand(10..70).to_f }
    user_id         { rand(0..1) }

  end

end
