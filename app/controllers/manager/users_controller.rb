class Manager::UsersController < ApplicationController
  before_filter :logged?, :current_user, :manager?, :current_company, except: [:new, :create]

  layout "manager", except: [:new]

  def index
    @employees = User.employees(@current_user.company_id) if @current_user.company_id.present?
  end

  def new
    @manager = User.new
  end

  def create
    @manager = User.new(params[:user])
    @manager.manager = true

    if @manager.save
      session[:id] = @manager.id
      session[:name] = @manager.name
      session[:manager] = @manager.manager?
      redirect_to action: :index
    else
      flash[:notice] = @manager.errors.full_messages
      redirect_to action: :new
    end
  end

  def edit
    @manager = @current_user
  end

  def update
    @manager = @current_user
    if @manager.update_attributes(params[:user])
      redirect_to manager_user_path
    else
      flash[:notice] = @manager.errors.full_messages
      redirect_to action: :edit
    end
  end

  def destroy
    if @current_user.destroy
      @current_company.destroy
      redirect_to logout_path
    else
      flash[:notice] = @current_user.errors.full_messages
      redirect_to action: :index
    end
  end
end