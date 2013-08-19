class UsersController < ApplicationController
  before_filter :logged?, :current_user
  before_filter :manager?, except: [:edit, :update]
  before_filter :user_found?, except: [:new, :create]

  layout "manager"

  def show
    @employee = User.find_by_username(params[:username])
    @checkings = @employee.checkings if @employee.checkings.present?
  end

  def new
    @employee = User.new
  end

  def edit
    @employee = if @current_user.manager?
      User.find_by_username(params[:username])
    else
      @current_user
    end
  end

  def create
    @employee = User.new(params[:user])
    @employee.manager = false
    @employee.company_id = @current_user.company_id

    if @employee.save
      redirect_to manager_users_path
    else
      flash[:notice] = @employee.errors.full_messages
      redirect_to action: :new
    end
  end

  def update
    @employee = User.find_by_username(params[:username])

    if @employee.update_attributes(params[:user])
      redirect_to user_path(@employee.username)
    else
      flash[:notice] = @employee.errors.full_messages
      redirect_to action: :edit
    end
  end

  def destroy
    @employee = User.find_by_username(params[:username])
    if @employee.destroy
      flash[:notice] = "Employee successfully removed"
      redirect_to '/manager'
    else
      flash[:notice] = @employee.errors.full_messages
      redirect_to action: :show
    end
  end

  protected
  def user_found?
    user = if @current_user.manager?
      User.find_by_username(params[:username])
    else
      @current_user
    end

    if user.nil? || not_same_company?(user)
      redirect_to root_path, notice: "Sorry! User not found."
    end
  end

  private
  def not_same_company?(user)
    return if user.nil?
    @current_user.company_id != user.company_id ? true : false
  end

end
