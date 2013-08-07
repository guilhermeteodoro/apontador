class Manager::UsersController < ApplicationController
  before_filter :logged?, :manager?, :current_user, except: [:new]
  respond_to :html

  def index
    @employees = User.employees(@current_user.company_id)
  end

  def show
    @employee = User.find(params[:id])
    respond_with @employee
  end

  def new
    @manager = User.new(manager: true)
    render 'signup'
  end

  def create
    @manager = User.new(params[:manager])
    if @manager.save
      session[id: @manager.id, name: @manager.name, manager: true]
      redirect_to action: :index
    end
  end

  def edit
    @employee = User.find(params[:id])
  end
end
