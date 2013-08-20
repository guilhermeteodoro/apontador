class CheckingsController < ApplicationController
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
    @checking = Checking.new(params[:checking])
    @checking.user_id = @current_user.id
    @checking.checked_in_at = Time.now

    if @checking.save
      flash[:notice] = "Checked-in successfully"
      redirect_to action: :edit
    else
      flash[:notice] = @checking.errors.full_messages
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

    if @current_user.location_ok?(params[:checking][:lat], params[:checking][:lng])
      @checking = @current_user.checkings.last

      if @checking.update_attributes(checked_out_at: Time.now)
        flash[:notice] = "Checked-out successfully"
        return redirect_to action: :new
      else
        flash[:notice] = @checking.errors.full_messages
        redirect_to action: :edit
      end
    else
      flash[:notice] = "You're out of the checking area"
      redirect_to action: :edit
    end

  end

  private
  def not_a_checker?
    redirect_to manager_user_path if session[:manager] == true
  end

end
