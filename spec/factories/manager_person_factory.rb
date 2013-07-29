# Factory inheritence

FactoryGirl.define do
  factory :manager, class: ManagerPerson, parent: :person do
    institution     { Faker::Name.last_name }
    cnpj            { 12345678901 }
  end
end
