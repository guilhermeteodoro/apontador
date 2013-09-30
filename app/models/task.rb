class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many :checkings

  # readonly :user_id
  attr_accessor :manager_account
  attr_accessible :description, :name, :hour_value, :duration, :user_id, :manager_account
  validates_presence_of :name, :description, :user_id, :company_id
  validates_format_of :duration, with: /([01]?[0-9]|2[0-3]):[0-5][0-9]/, unless: :manager_account
  validates :hour_value, :duration, presence: true, unless: :manager_account

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def completed_hours
    total_hours = 0
    checkings.each do |c|
      return if c.checked_in_at.nil? || c.checked_out_at.nil?
      total_hours += (c.time_difference[:hour].to_f + c.time_difference[:minute].to_f/100)
    end
    total_hours
  end

  def percentage
    total_hours = completed_hours
    ((total_hours * 100) / (formated_duration[:hour] + (formated_duration[:minute] / 100))).round(2)
  end

  def formated_duration
    h, m = read_attribute(:duration).split(":")
    {hour: h.to_f, minute: m.to_f}
  end

  def working_time(clock_style=false)
    tokens = formated_duration
    return nil if !tokens
    format = clock_style ? "%02d:%02d" : "%dh %dm"
    str    = sprintf(format,tokens[:hour],tokens[:minute])
    clock_style ? str : str.gsub(/(^0h | 0m)/,"")
  end
end