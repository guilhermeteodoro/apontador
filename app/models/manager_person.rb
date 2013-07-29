class ManagerPerson < ActiveRecord::Base
  #for multiple table inheritance gem (ActsAsRelation)
  acts_as :person

  attr_accessible :institution, :cnpj
  validates :institution, presence: true, allow_blank: false
  validates :cnpj, presence: true,
            uniqueness: true,
            length: { is: 11}

end
