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
    if checkings.size > 1
      checkings[0...-1].each do |c|
        total_hours += (c.time_difference[:hour] + (c.time_difference[:minute].to_f/100))
      end
      total_hours += ((Time.now - checkings.last.checked_in_at) / 1.hour)
    else
      total_hours = ((Time.now - checkings.first.checked_in_at) / 1.hour)
    end

    total_hours
  end

  def hashed_completed_hours
    h, m = completed_hours.to_s.split(".")
    {hour: h.to_i, minute: m.to_i}
  end

  def percentage
    total_hours = completed_hours
    ((total_hours * 100) / (hashed_duration[:hour] + (hashed_duration[:minute].to_f / 100))).round(2)
  end

  def hashed_duration
    h, m = read_attribute(:duration).split(":")
    {hour: h.to_f, minute: m.to_f}
  end

  def duration_to_float
    hour, minute = read_attribute(:duration).split(":")
    total = (hour.to_i.hours + minute.to_i.minutes).from_now - Time.now
    total / 1.hour
  end

  def self.hour_formater(clock_style=false, hash)
    tokens = hash
    return nil if !tokens
    format = clock_style ? "%02d:%02d" : "%dh %dm"
    str    = sprintf(format,tokens[:hour],tokens[:minute])
    clock_style ? str : str.gsub(/(^0h | 0m)/,"")
  end

end