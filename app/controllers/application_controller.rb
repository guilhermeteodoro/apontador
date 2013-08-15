class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def logged?
    redirect_to "/login" if session[:id].nil?
  end
  def manager?
    redirect_to "/login" if session[:manager] == false
  end
  def current_user
    @current_user = User.find(session[:id])
  end
  def current_company
    @current_company = User.find(session[:id]).company
  end
end
