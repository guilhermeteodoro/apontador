class Company < ActiveRecord::Base

  #associations
  has_many :users, dependent: :destroy

  #attributes
  attr_accessible :cnpj, :name

  #validations
  validates :name, presence: true
  validates :cnpj, presence: true
  validates_length_of :cnpj, is: 11

end
