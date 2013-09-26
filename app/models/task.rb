class Task < ActiveRecord::Base
  belongs_to :user
  has_many :checkings

  readonly :user_id
  attr_accessible :description, :name, :user_id
  validates_presence_of :name, :description, :user_id

end