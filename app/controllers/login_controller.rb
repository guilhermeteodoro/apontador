class LoginController < ApplicationController
  layout "adm", except: [:user]

  def adm
    render "adm_login"
  end
  def user
    render "login"
  end

  def login
    if request.post?
      email = params[:email]
      password = params[:password]
      if email.blank? && password.blank?
        flash[:notice] = "Invalid email or password"
        return
      end
      if email.blank?
        flash[:notice] = "Invalid email"
        return
      end
      if password.blank?
        flash[:notice] = "Invalid password"
        return
      end
      user = User.authenticate(email, password)
      p user
      if user.nil?
        flash[:notice] = "Invalid email or password"
        return
      end
      session[:id] = user.id
      session[:name] = "#{user.first_name} #{user.last_name}"
      session[:manager] = user.manager?
    end
  end

  def logout
    session[:id] = nil
    session[:name] = nil
    session[:manager] = nil
    redirect_to action: :login
  end
end
