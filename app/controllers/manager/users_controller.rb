class Manager::UsersController < ApplicationController
  layout :resolve_layout

  before_filter :logged?, :current_user, :manager?, :current_company, except: [:new, :create]

  def index
    @employees = User.employees(@current_user.company_id) if @current_user.company_id.present?
  end

  def new
    @manager = User.new
  end

  def create
    @manager = User.new(params[:user])
    @manager.manager = true
    @manager.hour_value = 1

    if @manager.save
      session[:id] = @manager.id
      session[:name] = @manager.name
      session[:manager] = @manager.manager?
      redirect_to action: :index
    else
      flash[:error] = @manager.errors.full_messages
      redirect_to action: :new
    end
  end

  def edit
    @manager = @current_user
  end

  def update
    @manager = @current_user
    if @manager.update_attributes(params[:user])
      flash[:notice] = "Dados alterados com sucesso"
      redirect_to manager_user_path
    else
      flash[:error] = @manager.errors.full_messages
      redirect_to action: :edit
    end
  end

  def destroy
    if @current_user.destroy
      @current_company.destroy if @current_company.present?
      redirect_to logout_path
    else
      flash[:error] = @current_user.errors.full_messages
      redirect_to action: :index
    end
  end

  private
  def resolve_layout
    if action_name == "new"
      "login"
    else
      "manager"
    end
  end
end