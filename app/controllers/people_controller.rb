class PeopleController < ApplicationController
  before_filter :logged?
  respond_to :html

  def index
    @people = Person.find params[:admin]
    respond_with @people
  end

  def logged?
    redirect_to '/login' if session[:id].nil?
  end
end
