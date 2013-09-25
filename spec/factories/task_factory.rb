FactoryGirl.define do

  factory :task do
    sequence(:name) {|s| "Task#{s}"}
    description "Many, many, many descriptions!"
  end

end