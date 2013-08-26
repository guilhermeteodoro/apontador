class Checking < ActiveRecord::Base

  #associations
  belongs_to :user

  #attributes
  attr_accessible :checked_in_at, :checked_out_at, :value, :lat, :hour_value, :lng, :approved, :paid, :user_id

  #validations
  validates :hour_value, presence: true, allow_blank: false
  validates :checked_out_at, presence: true
  validates :user_id, presence: true

  #scopes
  scope :approveds, conditions: { approved: true, paid: false }
  scope :not_approveds, conditions: { approved: false, paid: false }
  scope :paids, conditions: { paid: true }

  def date(checked_at)
    checked_at.strftime("%d/%m/%Y") if checked_at.present?
  end

  def time(checked_at)
    checked_at.strftime("%H:%M") if checked_at.present?
  end

  def weekday(checked_at)
    checked_at.strftime("%A")
  end

  def working_time(clock_style=false)
    if checked_in_at.present? && checked_out_at.present?
      h, m = ((checked_out_at - checked_in_at) / 1.hour).to_s.split('.')
      m = ((m.to_f / (10 ** m.length.to_i)) * 60).round

      if clock_style
        hours = if h.to_s.length < 2
          "0#{h}"
        else
          "#{h}"
        end

        minutes = if m.to_s.length < 2
          "0#{m}"
        else
          "#{m}"
        end

        "#{hours}:#{minutes}"

      else
        if h.to_i < 1
          "#{m}m"
        elsif m < 1
          "#{h}h"
        else
          "#{h}h #{m}m"
        end
      end

    end
  end

  def set_value(value=nil)
    if checked_in_at.present? && checked_out_at.present?
      if value.nil? || hour_value.present?
        self.value = ((checked_out_at-checked_in_at)/1.hour*hour_value)
      else
        self.value = ((checked_out_at-checked_in_at)/1.hour*value)
      end
    end
  end

end
