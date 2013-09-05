class Payment < ActiveRecord::Base

  #associations
  belongs_to :user
  has_many :checkings, through: :user

  #attributes
  attr_accessible :concluded, :date, :token

  #validations

end
