class Hour < ActiveRecord::Base
  belongs_to :person

  attr_accessible :checked_in_at, :checked_out_at, :person_id, :value
  validates :person_id, :checked_in_at, :checked_out_at, presence: true, allow_blank: false

  def weekday(checking)
    wday = checking.wday
    return "Sunday"     if wday == 0
    return "Monday"     if wday == 1
    return "Tuesday"    if wday == 2
    return "Wednesday"  if wday == 3
    return "Thursday"   if wday == 4
    return "Friday"     if wday == 5
    return "Saturday"   if wday == 6
  end
  def date(checking)
    "#{checking.day}/#{checking.month}/#{checking.year}"
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
