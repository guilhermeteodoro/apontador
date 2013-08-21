class Company < ActiveRecord::Base

  #associations
  has_many :users, dependent: :destroy

  #attributes
  attr_accessible :cnpj, :name

  #validations
  validates :name, presence: true, allow_blank: false
  validates :cnpj, presence: true
  validates_length_of :cnpj, is: 11

end