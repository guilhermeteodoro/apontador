class Person < ActiveRecord::Base
  attr_accessible :address, :admin, :city, :cpf, :first_name, :last_name, :phone
  validates :first_name, presence: true
end
