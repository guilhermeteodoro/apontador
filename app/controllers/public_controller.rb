class PublicController < ApplicationController

  def index
  end

  def redirecter
    return redirect_to index_path unless session[:id]
    session[:manager] ? (redirect_to manager_users_path) : (redirect_to check_in_path)
  end

end