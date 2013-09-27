class Company < ActiveRecord::Base

  #associations
  has_many :users, dependent: :destroy
  has_many :tasks

  #attributes
  attr_accessible :cnpj, :name

  #validations
  validates :name, presence: true
  validates :cnpj, presence: true, length: { is: 11 }
end
