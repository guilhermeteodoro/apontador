#encoding: UTF-8
class UsersController < ApplicationController

  layout :resolve_layout

  before_filter :logged?, :current_user
  before_filter :manager?, except: [:edit, :update, :report]
  before_filter :user_found?, except: [:new, :create, :report]
  before_filter :employee?, only: [:edit, :update]

  def show
    @employee = User.find_by_username(params[:username])
    @checkings = @employee.checkings if @employee.checkings.present?
  end

  def new
    @employee = User.new
  end

  def edit
  end

  def report
    @employee = @current_user
  end

  def create
    @employee = User.new(params[:user])
    @employee.manager = false
    @employee.company_id = @current_user.company_id
    temp_pass = SecureRandom.hex(4)
    @employee.plain_password = (temp_pass)

    if @employee.save

      UserMailer.welcome_email(@employee, @current_user, temp_pass).deliver
      flash[:notice] = "#{@employee.name} criado com sucesso"
      redirect_to manager_users_path
    else
      flash[:error] = @employee.errors.full_messages
      redirect_to action: :new
    end
  end

  def update
    if @employee.update_attributes(params[:user])
      if @current_user.manager?

        if @employee.changed_to.present?
          UserMailer.user_update_email(@employee, @employee.changed_to).deliver
          flash[:notice] = "Informações do funcionário atualizadas com sucesso"
        end

        redirect_to user_path(@employee.username)
      else
        redirect_to check_in_path
      end
    else
      flash[:error] = @employee.errors.full_messages
      redirect_to action: :edit
    end
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
    user = if @current_user.manager?
      User.find_by_username(params[:username])
    else
      @current_user
    end

    if user.nil? || not_same_company?(user)
      redirect_to root_path, error: "Ops! Usuário não encontrado"
    end
  end

  private
  def not_same_company?(user)
    return if user.nil?
    @current_user.company_id != user.company_id ? true : false
  end

  def employee?
    @employee = if @current_user.manager?
      User.find_by_username(params[:username])
    else
      @current_user
    end
  end

  def resolve_layout
    case action_name
      when "edit"
        if @current_user.manager? == false
          return "employee"
        end
      when "report"
        return "employee"
    end

    "manager"
  end

end
