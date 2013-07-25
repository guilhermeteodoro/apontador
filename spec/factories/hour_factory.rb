FactoryGirl.define do
  factory :hour, class: Hour do
    checked_in_at   { Time.now }
    checked_out_at  { Time.now + rand(1..4).hours }
    value           { rand(10..70).to_f }
    person_id       { rand(0..1) }
  end
end
