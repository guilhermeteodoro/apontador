#encoding: UTF-8
class CheckingsController < ApplicationController
  layout "employee"

  before_filter :logged?, :current_user, :not_a_checker?
  before_filter :coordinates?, only: [:create, :update]

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
      flash[:error] = "Você está fora da área de checagem ou possivelmente com o GPS desligado"
      redirect_to action: :new
    end
  end

  def edit
    if @current_user.checkings.present?

      if @current_user.checkings.last.checked_out_at.present?
        redirect_to action: :new
      else
        @checking = @current_user.checkings.last
        render 'edit'
      end

      @checking = @current_user.checkings.last
    else
      redirect_to action: :new
    end
  end

  def update

    if @current_user.location_ok?(params[:checking][:lat].to_f, params[:checking][:lng].to_f)
      @checking = @current_user.checkings.last
      @checking.checked_out_at = Time.now
      @checking.set_value

      if @checking.update_attributes(checked_out_at: Time.now, value: @checking.value)
        flash[:notice] = "Checagem finalizada com sucesso"
        return redirect_to action: :new
      else
        flash[:error] = @checking.errors.full_messages
        redirect_to action: :edit
      end
    else
      flash[:error] = "Você está fora da área de checagem ou possivelmente com o GPS desligado"
      redirect_to action: :edit
    end

  end

  private
  def coordinates?
    if @current_user.latitude.nil? || @current_user.longitude.nil?
      flash[:error] = "Há um problema com o seu cadastro e não foi possível geolocalizar, entre em contato com o seu gerente."
      redirect_to check_in_path
    end
  end
  def not_a_checker?
    redirect_to manager_user_path if session[:manager] == true
  end

end
