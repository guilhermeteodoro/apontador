#encoding: UTF-8
class UsersController < ApplicationController

  layout :resolve_layout

  before_filter :logged?, :current_user
  before_filter :manager?, except: [:edit, :update, :report]
  before_filter :user_found?, except: [:new, :create, :report, :destroy]

  def show
    @employee = @user
  end

  def new
    @employee = User.new
  end

  def edit
    @employee = @user
  end

  def report
    @employee = @current_user
  end

  def create
    @employee = User.new(params[:user])
    @employee.company_id = @current_user.company_id
    temp_pass = SecureRandom.hex(4)
    @employee.plain_password = (temp_pass)

    if @employee.save
      Thread.new {UserMailer.welcome_email(@employee, @current_user, temp_pass).deliver}
      flash[:notice] = "Funcionário criado com sucesso"
      redirect_to manager_users_path
    else
      flash[:error] = @employee.errors.full_messages
      redirect_to action: :new
    end
  end

  def update
    @employee = @user

    if !@employee.update_attributes(params[:user])
      flash[:error] = @employee.errors.full_messages
      redirect_to action: :edit
      return
    end

    if !@current_user.manager?
      redirect_to check_in_path
      return
    end

    if @employee.changed_to.present?
      Thread.new {UserMailer.user_update_email(@employee, @employee.changed_to).deliver}
      flash[:notice] = "Informações do funcionário atualizadas com sucesso"
    end
    redirect_to user_path(@employee.username)
  end

  def destroy
    @employee = User.find_by_username(params[:username])
    if @employee.destroy
      flash[:notice] = "Funcionário removido"
      redirect_to '/manager'
    else
      flash[:error] = @employee.errors.full_messages
      redirect_to action: :show
    end
  end

  protected
  def user_found?
    @user = if @current_user.manager?
      User.includes(:checkings).find_by_username(params[:username])
    else
      @current_user
    end

    if @user.nil? || (@current_user.company_id != @user.company_id)
      redirect_to root_path, error: "Ops! Usuário não encontrado"
    end
  end

  private
  def resolve_layout
    return "application" if action_name=="report" || (action_name=="edit" && !@current_user.manager?)
    "manager"
  end
end
