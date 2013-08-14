class Checking < ActiveRecord::Base
  belongs_to :user

  attr_accessible :checked_in_at, :checked_out_at, :user_id, :hour_value, :lat, :lng, :value, :approved

  validates :user_id, presence: true
  # validates :checked_in_at, :checked_out_at, :user_id, allow_blank: false

  def date(checked_at)
    checked_at.strftime("%d/%m/%Y") if checked_at.present?
  end

  def time(checked_at)
    checked_at.strftime("%H:%M") if checked_at.present?
  end

  def weekday(checked_at)
    checked_at.strftime("%A")
  end

  def worktime
    hours = if (checked_out_at.hour - checked_in_at.hour).to_s.length < 2
      "0#{(checked_out_at.hour - checked_in_at.hour)}"
    else
      (checked_out_at.hour - checked_in_at.hour).to_s
    end
    minutes = if (checked_out_at.min - checked_in_at.min).to_s.length < 2
      "0#{(checked_out_at.min - checked_in_at.min)}"
    else
      (checked_out_at.min - checked_in_at.min).to_s
    end
    "#{hours}:#{minutes}"
  end
end
