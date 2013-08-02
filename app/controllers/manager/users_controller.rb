class Manager::UsersController < ApplicationController
  before_filter :logged?, :manager?, :current_user
  respond_to :html

  def index
    @employees = User.employees(@current_user.company_id)
  end

  def show
    @employee = User.find(params[:id])
    respond_with @user
  end

  def edit
    @employee = User.find(params[:id])
  end

end
