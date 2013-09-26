class LoggedController < ApplicationController
  before_filter :logged?, :current_user
end