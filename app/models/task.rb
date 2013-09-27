class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many :checkings

  # readonly :user_id
  attr_accessible :description, :name, :hour_value, :duration, :user_id
  validates_presence_of :name, :description, :user_id, :company_id
  validates_format_of :duration, with: /([01]?[0-9]|2[0-3]):[0-5][0-9]/, allow_nil: true

  def to_param
    "#{id}-#{name.parameterize}"
  end

end