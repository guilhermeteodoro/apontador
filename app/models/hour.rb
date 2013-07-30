class Hour < ActiveRecord::Base
  belongs_to :user

  attr_accessible :checked_in_at, :checked_out_at, :user_id, :value
  validates :user_id, :checked_in_at, :checked_out_at, presence: true, allow_blank: false

  def weekday(checking)
    checking.strftime("%A")
  end
  def date(checking)
    checking.strftime("%d/%m/%Y")
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
