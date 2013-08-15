class CheckingsController < ApplicationController
  before_filter :logged?, :current_user, :not_a_checker?

  def new
    if @current_user.checkings.last.checked_in_at.present? && @current_user.checkings.last.checked_out_at.nil?
      redirect_to action: :edit
    else
      @checking = Checking.new
      render 'new'
    end
  end

  def create
    @checking = Checking.new(params[:checking])
    @checking.user_id = @current_user.id
    @checking.checked_in_at = Time.now

    if @checking.save
      p '/////////////////////////////////////'
      p 'save'
      flash[:notice] = "Checked-in successfully"
      respond_to { |format| format.html { redirect_to action: :edit } }
    else
      p '/////////////////////////////////////'
      p 'nao save'
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
  end

  def update
    @checking = Checking.new(params[:checking])

    if @checking.update_attributes(checked_out_at: Time.now)
      flash[:notice] = "Checked-out successfully"
      respond_to { |format| format.html { redirect_to action: :new } }
    else
      flash[:notice] = @checking.errors.full_messages
      redirect_to { |format| format.html { redirect_to action: :edit } }
    end
  end

  private
  def not_a_checker?
    redirect_to manager_user_path if session[:manager] == true
  end

end
