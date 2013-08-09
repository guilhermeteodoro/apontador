class UsersController < ApplicationController
  before_filter :logged?, :current_user
  respond_to :html

  def new
  end
end
