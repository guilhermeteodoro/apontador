class EmployeePerson < ActiveRecord::Base
  #for multiple table inheritance gem (ActsAsRelation)
  acts_as :person

  attr_accessible :cpf
  validates :cpf, presence: true, uniqueness: true, length: { is: 11}

end
