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
      if user.nil?
        flash[:notice] = "Invalid email or password"
        return
      end
      p session[:id] = user.id
      session[:name] = user.name
      session[:manager] = user.manager?
      if session[:manager]
        redirect_to "/manager"
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
