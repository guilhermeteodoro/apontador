class CheckingsController < ApplicationController
  before_filter :logged?, :current_user

  def new
    @checking = Checking.new(user_id: @current_user.id)
    @checking.save
    render 'index'
  end

  def create
    @checking = @current_user.checkings.last
    @checking.checked_in_at = Time.now
    @checking.lat, @checking.lng = params[:lat], params[:lng]


    if @checking.save
      flash[:notice] = "Checked-in successfully"
      render 'checked'
    else
      flash[:notice] = "There's been an error, try again"
      redirect_to action: :new
    end
  end

  def update
    @checking = Checking.last_check_in(@current_user.id)

    if @checking.update_attributes(checked_out_at: Time.now)
      flash[:notice] = "Checked-out successfully"
      render 'index'
    else
      flash[:notice] = "There's been an error, try again"
    end
  end
end
