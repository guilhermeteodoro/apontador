class Task < ActiveRecord::Base
  belongs_to :user
  has_many :checkings

  attr_accessible :description, :name
  validates_presence_of :name, :description

end