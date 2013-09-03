module SpecTestHelper

  def sign_in(user)
    user = User.find(user.id)
    request.session[:id] = user.id
    request.session[:name] = user.name
    request.session[:manager] = user.manager
  end

end