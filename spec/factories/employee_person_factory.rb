FactoryGirl.define do
  factory :employee, class: EmployeePerson, parent: :person do
    cpf { 12345678901 }
  end
end
