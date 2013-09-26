# encoding: UTF-8
class SessionsController < ApplicationController

  def login
    if request.post?
      reset_session
      username = params[:username]
      password = params[:password]
      if username.blank? && password.blank?
        flash[:error] = "Username/email ou senha inválida"
        return
      end
      if username.blank?
        flash[:error] = "Username/email inválido"
        return
      end
      if password.blank?
        flash[:error] = "Senha inválida"
        return
      end
      user = User.authenticate(username: username, password: password)
      if user.nil?
        flash[:error] = "Username/email ou senha inválida"
        return
      end
      session[:id] = user.id
      session[:name] = user.name
      session[:manager] = user.manager?
      if session[:manager]
        redirect_to manager_users_path
      else
        redirect_to check_in_path
      end
    end
  end

  def logout
    reset_session
    redirect_to action: :login
  end
end
