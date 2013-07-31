class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def logged?
    redirect_to "/login" if session[:id].nil?
  end
  def manager?
    redirect_to "/login" if !session[:manager]
  end
  def current_user
    @user = User.find(session[:id])
  end
end
