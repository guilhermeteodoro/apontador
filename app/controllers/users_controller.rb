class UsersController < ApplicationController
  before_filter :logged?
  respond_to :html

  def index
    @users = User.find params[:manager]
    respond_with @users
  end

  def logged?
    redirect_to '/login' if session[:id].nil?
  end
end
