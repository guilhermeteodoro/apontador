class Manager::UsersController < ApplicationController
  before_filter :logged?, :manager?, :current_user, except: [:new, :create]
  respond_to :html

  def index
    @employees = User.employees(@current_user.company_id) if @current_user.company_id.present?
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
    @manager = User.new(params[:user])
    @manager.manager = true

    if @manager.save
      p session[:id] = @manager.id
      p session[:name] = @manager.name
      p session[:manager] = @manager.manager?
      redirect_to action: :index
    else
      flash[:notice] = @manager.errors.full_messages
      redirect_to action: :new
    end
  end

  def edit
    @employee = User.find(params[:id])
  end
end
