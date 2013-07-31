class Company < ActiveRecord::Base
  has_many :users

  attr_accessible :cnpj, :name
  validates :name, presence: true, allow_blank: false
  validates :cnpj, presence: true
  validates_length_of :cnpj, is: 11
end
