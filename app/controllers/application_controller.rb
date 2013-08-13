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
  def same_company?
    render root_path unless @current_user.company_id == @employee.company_id
  end
end
