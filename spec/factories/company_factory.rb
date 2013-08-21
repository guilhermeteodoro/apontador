FactoryGirl.define do

  factory :company, class: Company do

    name  { Faker::Name.last_name }
    cnpj  { 12345678901 }

  end

end
