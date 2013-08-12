class LoginController < ApplicationController
  def redirecter
    if session[:id].present?
      if session[:manager]
        redirect_to '/manager'
      else
        redirect_to '/checking'
      end
    else
      redirect_to action: :login
    end
  end

  def login
    if request.post?
      username = params[:username]
      password = params[:password]
      if username.blank? && password.blank?
        flash[:notice] = "Invalid username/email or password"
        return
      end
      if username.blank?
        flash[:notice] = "Invalid username/email"
        return
      end
      if password.blank?
        flash[:notice] = "Invalid password"
        return
      end
      user = User.authenticate(username: username, password: password)
      if user.nil?
        flash[:notice] = "Invalid username/email or password"
        return
      end
      session[:id] = user.id
      session[:name] = user.name
      session[:manager] = user.manager?
      if session[:manager]
        redirect_to manager_users_path
      else
        redirect_to "/checking"
      end
    end
  end

  def logout
    session[:id] = nil
    session[:name] = nil
    session[:manager] = nil
    redirect_to action: :login
  end
end
