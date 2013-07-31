class CheckingsController < ApplicationController
  def check_in
    checking = Check.new(checked_in_at: Time.now, user_id: @user.id)
    checking.save
  end
  def check_out
    check = Check.find(id: checking.id)
    check.checked_out_at = Time.now
    check.save
  end
end
