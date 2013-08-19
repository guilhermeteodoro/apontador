#encoding: UTF-8

class UserPresenter
  attr_reader :user
  delegate :id, :name, :username, :email, :manager, to: :user

  def initialize(params)
    @user = params[:manager]
    @employee = params[:employee]
  end

  def edit_employee_title
    @user.manager? ? "Employee" : "Information"
  end

  def edit_employee_form_url
    @user.manager? ? "user_path(@employee.username)" : "edit_employee_user_path"
  end

end