#encoding: UTF-8

class UserPresenter
  attr_reader :user
  delegate :id, :name, :username, :email, :manager, to: :user

  def initialize(params)
    @user = params[:manager]
    @employee = params[:employee]
  end

  def edit_employee_title
    @current_user.manager? ? "Employee" : "Information"
  end

  def edit_employee_form
    if @user.manager?
      user_path(@user.username)
    else
      edit_employee_user_path
  end
end