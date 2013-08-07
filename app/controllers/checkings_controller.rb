class CheckingsController < ApplicationController
  before_filter :logged?, :current_user
  before_filter :last_checking, only: [:create, :update]

  def new
    if @current_user.checkings.last.checked_in_at.nil?
      @checking = @current_user.checkings.last
      render 'index'
    elsif @current_user.checkings.last.checked_out_at.nil?
      @checking = @current_user.checkings.last
      render 'checked'
    else
      @checking = Checking.new(user_id: @current_user.id)
      render 'index'
    end
  end

  def create
    if @current_user.location_ok?(@checking.lat, @checking.lng)

      @checking.checked_in_at = Time.now

      if @checking.save
        flash[:notice] = "Checked-in successfully"
        render 'checked'
      else
        flash[:notice] = "There's been an error, try again"
        redirect_to action: :new
      end
    else
      flash[:notice] = "Impossible to continue: out of range"
      redirect_to action: :new
    end
  end

  def update
    if @current_user.location_ok?(@checking.lat, @checking.lng)

      if @checking.update_attributes(checked_out_at: Time.now)
        flash[:notice] = "Checked-out successfully"
        redirect_to action: :new
      else
        flash[:notice] = "There's been an error, try again"
        render 'checked'
      end

    else
      flash[:notice] = "Impossible to continue: out of range"
      render 'checked'
    end
  end

  private
  def last_checking
    @checking = @current_user.checkings.last
    @checking.lat, @checking.lng = params[:lat], params[:lng]
  end
end
