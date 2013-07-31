class Manager::UsersController < ApplicationController
  before_filter :logged?, :manager?, :current_user
  respond_to :html

  def index
    @employees = User.employees(@user.company_id)
    respond_with :html
  end

  def show
    @employee = User.find(params[:id])
  end

  def edit
    @employee = User.find(params[:id])
  end

end
