class CheckingsController < ApplicationController
  layout "employee"

  before_filter :logged?, :current_user, :not_a_checker?

  def new
    if @current_user.checkings.present?
      if @current_user.checkings.last.checked_in_at.present? && @current_user.checkings.last.checked_out_at.nil?
        return redirect_to action: :edit
      end
    end

    @checking = Checking.new
    render 'new'
  end

  def create
    if @current_user.location_ok?(params[:checking][:lat].to_f, params[:checking][:lng].to_f)
      @checking = Checking.new(params[:checking])
      @checking.user_id = @current_user.id
      @checking.checked_in_at = Time.now
      @checking.hour_value = @current_user.hour_value
      @checking.approved = false

      if @checking.save
        redirect_to action: :edit
      else
        flash[:error] = @checking.errors.full_messages
        redirect_to action: :new
      end
    else
      flash[:error] = "You're out of the checking area"
      redirect_to action: :new
    end
  end

  def edit
    if @current_user.checkings.last.checked_out_at.present?
      redirect_to action: :new
    else
      @checking = @current_user.checkings.last
      render 'edit'
    end
    @checking = @current_user.checkings.last
  end

  def update

    if @current_user.location_ok?(params[:checking][:lat].to_f, params[:checking][:lng].to_f)
      @checking = @current_user.checkings.last
      @checking.checked_out_at = Time.now
      @checking.set_value

      if @checking.update_attributes(checked_out_at: Time.now, value: @checking.value)
        return redirect_to action: :new
      else
        flash[:error] = @checking.errors.full_messages
        redirect_to action: :edit
      end
    else
      flash[:error] = "You're out of the checking area"
      redirect_to action: :edit
    end

  end

  private
  def not_a_checker?
    redirect_to manager_user_path if session[:manager] == true
  end

end
