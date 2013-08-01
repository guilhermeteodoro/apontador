class Checking < ActiveRecord::Base
  belongs_to :user

  attr_accessible :checked_in_at, :checked_out_at, :user_id, :hour_value
  validates :user_id, presence: true, allow_blank: false
  # scope :last_check_in, ->(user_id) { where(["user_id=? and checked_out_at=?", user_id, nil]).last }

  def date(checked_at)
    checked_at.strftime("%d/%m/%Y")
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
  def self.last_check_in(current_user_id)
    where(user_id: current_user_id, checked_out_at: nil).last
  end
end
