class UsersController < ApplicationController
  before_filter :logged?, :current_user
  respond_to :html

  def index
    #current user: @user

    respond_with @current_user
  end
end
