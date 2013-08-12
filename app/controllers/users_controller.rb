class UsersController < ApplicationController
  before_filter :logged?, :current_user
  before_filter :manager?, except: [:edit, :show]
  respond_to :html

  def new
    @employee = User.new
  end

  def show
    @employee = User.find(params[:id])
    @checkings = Checking.find(user_id: @employee.id)
  end

  def create
    @employee = User.new(params[:user])
    @employee.manager = false
    @employee.company_id = @current_user.company_id

    if @employee.save
      redirect_to manager_index_path
    else
      flash[:notice] = @employee.errors.full_messages
      redirect_to action: :new
    end
  end

  def edit
    @employee = User.find(params[:id])
  end

  def update
    @employee = User.find(params[:id])

    if @employee.update_attributes(params[:user])
      redirect_to user_path
    else
      flash[:notice] = "It's been an error, try again"
      redirect_to action: :edit
    end
  end

  def destroy

  end

end
