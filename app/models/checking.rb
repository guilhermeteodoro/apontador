class Checking < ActiveRecord::Base

  #associations
  belongs_to :user

  #attributes
  attr_accessible :checked_in_at, :checked_out_at, :value, :lat, :hour_value, :lng, :approved, :paid, :user_id

  #validations
  validates :hour_value, presence: true
  validates :checked_in_at, presence: true
  validates :user_id, presence: true

  #scopes
  scope :approveds, conditions: { approved: true, paid: false }
  scope :not_approveds, conditions: { approved: false, paid: false }
  scope :paids, conditions: { paid: true }

  def date(checked_at)
    (checked_at-3.hour).strftime("%d/%m/%Y") if checked_at.present?
  end

  def time(checked_at)
    (checked_at-3.hour).strftime("%H:%M") if checked_at.present?
  end

  def weekday(checked_at)
    checked_at.strftime("%A")
  end

  def time_difference
    return nil if checked_in_at.blank? || checked_out_at.blank?
    hour, minute = ((checked_out_at - checked_in_at) / 1.hour).to_s.split('.')
    minute       = ((minute.to_f / (10 ** minute.length.to_i)) * 60).round
    {hour: hour.to_i, minute: minute.to_i}
  end

  def working_time(clock_style=false)
    tokens = time_difference
    return nil if !tokens
    format = clock_style ? "%02d:%02d" : "%dh %dm"
    str    = sprintf(format,tokens[:hour],tokens[:minute])
    clock_style ? str : str.gsub(/(^0h | 0m)/,"")
  end

  def set_value(value=nil)
    tokens = time_difference
    return if !tokens
    self.value = (tokens[:hour] + tokens[:minute]/60) * (value || hour_value || 0)
  end
end
